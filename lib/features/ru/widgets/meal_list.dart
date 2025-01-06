import 'package:flutter/material.dart';
import 'package:ufcat_app/features/ru/widgets/container_ru.dart';

class MealList extends StatelessWidget {
  final Map<String, dynamic> filteredInfos;

  final Map<String, String> texts = {
    'prato_principal': 'Prato Principal',
    'vegano/vegetariano': 'Prato Vegano/Vegetariano',
    'acompanhamento': "Acompanhamento",
    'guarnicao': 'Guarnição',
    'sobremesa': 'Sobremesa',
    'salada': 'Salada'
  };

  String title(String text) {
    return texts[text] ?? '';
  }

  MealList({
    super.key,
    required this.filteredInfos,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: texts.entries.map((entry) {
          if (filteredInfos.containsKey(entry.key)) {
            return ContainerRu(
              title: entry.value,
              content: filteredInfos[entry.key],
            );
          } else {
            return const SizedBox.shrink();
          }
        }).toList(),
      ),
    );
  }
}
