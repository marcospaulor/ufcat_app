import 'package:flutter/material.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class DropdownSelector extends StatelessWidget {
  final String hintText;
  final String label;
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const DropdownSelector({
    Key? key,
    this.label = "",
    this.hintText = "",
    required this.items,
    required this.onChanged,
    this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      iconSize: 30,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyLarge!,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge!,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            color: grayUfcat,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      value: selectedValue,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, selecione um item';
        }
        return null;
      },
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge!,
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
