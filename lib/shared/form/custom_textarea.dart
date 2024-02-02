import 'package:flutter/material.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final void Function(String)? onChanged;

  const CustomTextArea({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 5, // Permite múltiplas linhas
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        hintText: hintText,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: grayUfcat),
        ),
      ),
    );
  }
}
