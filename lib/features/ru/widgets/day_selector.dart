import 'package:flutter/material.dart';
import 'package:ufcat_app/features/ru/widgets/sticky_button.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class DaySelector extends StatelessWidget {
  final Future<Map<String, dynamic>> cardapio;
  final String day;
  final double height;
  final void Function(String) onDaySelected;

  const DaySelector({
    Key? key,
    required this.cardapio,
    required this.day,
    required this.height,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: cardapio,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox.shrink();
        } else if (snapshot.hasError) {
          return const SizedBox.shrink();
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        } else {
          final cardapio = snapshot.data!;
          return Positioned(
            left: 0,
            top: height * (1 / 3) - kToolbarHeight - kTextTabBarHeight,
            child: SizedBox(
              height: height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cardapio.entries
                    .map(
                      (e) => StickyButton(
                        label: e.key[0],
                        size: day == e.key ? 0.2 : 0.1,
                        color: day == e.key ? orangeUfcat : greenUfcat,
                        onPressed: () => onDaySelected(e.key),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        }
      },
    );
  }
}
