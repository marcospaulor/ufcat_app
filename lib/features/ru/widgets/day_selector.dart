import 'package:flutter/material.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:ufcat_app/features/ru/widgets/sticky_button.dart';

class DaySelector extends StatelessWidget {
  final String day;
  final double height;
  final void Function(String) onDaySelected;

  const DaySelector({
    Key? key,
    required this.day,
    required this.height,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderedDays = ['Segunda', 'Terca', 'Quarta', 'Quinta', 'Sexta'];
    return Positioned(
      left: 0,
      top: height * (1 / 3) - kToolbarHeight - kTextTabBarHeight,
      child: SizedBox(
        height: height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: orderedDays.map((dayKey) {
            return StickyButton(
              label: dayKey[0],
              size: day == dayKey ? 0.2 : 0.1,
              color: day == dayKey ? orangeUfcat : greenUfcat,
              onPressed: () => onDaySelected(dayKey),
            );
          }).toList(),
        ),
      ),
    );
  }
}
