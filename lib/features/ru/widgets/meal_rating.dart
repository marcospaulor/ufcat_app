import 'package:flutter/material.dart';
import 'package:ufcat_app/features/rating/pages/rating_screen.dart';
import 'package:ufcat_app/shared/star_rating.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

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
    // Agora você pode acessar 'Avaliação' no mapa de dados
    int rating = filteredInfos['Avaliação'];

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
              child: Row(
                children: [
                  StarRating(
                    padding: 6.0,
                    size: 20.0,
                    allowRating: false,
                    rating: rating,
                    onRatingChanged: (value) => rating = value,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '$rating',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
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
}
