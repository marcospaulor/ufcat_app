import 'package:flutter/material.dart';
import 'package:ufcat_app/features/ru/widgets/container_ru.dart';

class MealList extends StatelessWidget {
  final Map<String, dynamic> filteredInfos;

  const MealList({
    Key? key,
    required this.filteredInfos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: List<Widget>.from(
          filteredInfos.entries
              .where((e) => e.key != "Avaliação")
              .map((e) => ContainerRu(
                    title: e.key,
                    content: e.value,
                  )),
        ),
      ),
    );
  }
}
