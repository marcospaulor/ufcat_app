import 'package:flutter/material.dart';
import 'package:ufcat_app/features/ru/widgets/meal_list.dart';
import 'package:ufcat_app/features/ru/widgets/meal_rating.dart';

class MealTab extends StatelessWidget {
  final Map<String, dynamic> menu;
  final String day;
  final String mealType;

  const MealTab({
    Key? key,
    required this.menu,
    required this.day,
    required this.mealType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDay = _formatDay(day);

    return FutureBuilder<Map<String, dynamic>>(
      future: Future<Map<String, dynamic>>.value(menu),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available.');
        } else {
          final Map<String, dynamic> cardapio = snapshot.data!;
          final filteredInfos = cardapio[formattedDay][mealType];

          return Column(
            children: [
              MealRating(
                filteredInfos: filteredInfos,
                day: formattedDay,
                mealType: mealType.contains("almoco") ? 0 : 1,
              ),
              MealList(filteredInfos: filteredInfos),
            ],
          );
        }
      },
    );
  }

  String _formatDay(String day) {
    return day.toLowerCase() + "-feira";
  }
}
