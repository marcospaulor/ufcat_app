import 'package:flutter/material.dart';
import 'package:ufcat_app/features/rating/pages/rating_screen.dart';
import 'package:ufcat_app/shared/star_rating.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealRating extends StatelessWidget {
  final Map<String, dynamic> filteredInfos;
  final String day;
  final int mealType;

  const MealRating({
    Key? key,
    required this.filteredInfos,
    required this.day,
    required this.mealType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: _calculateAverageRatingForDay(day), // Convertendo o dia para minúsculas
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error calculating average rating');
        } else {
          final double rating = snapshot.data ?? 3.0;

          return Container(
            height: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.black.withOpacity(0.2),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13.0,
                      vertical: 1.0,
                    ),
                    child: StarRating(
                      padding: 6.0,
                      size: 20.0,
                      allowRating: false,
                      rating: rating.toInt(),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RatingScreen(
                            dataMeal: filteredInfos,
                            currentDay: day,
                            selectedMeal: mealType,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orangeUfcat,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 51.0,
                        vertical: 10.0,
                      ),
                      child: Text('Avaliar'),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<double> _calculateAverageRatingForDay(String day) async {
    // transform first letter in Uppercase
    final handleDay = day.substring(0, 1).toUpperCase() + day.substring(1);
    final handleMeal = mealType == 0 ? 'Almoço' : 'Jantar';

    double totalRating = 0.0;
    int numberOfRatings = 0;

    final ratingsRef = FirebaseFirestore.instance
      .collection('ru')
      .doc('rating')
      .collection('avaliacoes');


    final querySnapshot = await ratingsRef
      .where('day', isEqualTo: handleDay)
      .where('meal', isEqualTo: handleMeal)
      .get();


    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      final rating = data['rating'] ?? 0.0;
      totalRating += rating;
      numberOfRatings++;
    }

    final averageRating = numberOfRatings > 0 ? totalRating / numberOfRatings : null;
    return averageRating ?? 3.0;
  }
}
