import 'package:flutter/material.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isPassword;
  // keyboardType
  final TextInputType? keyboardType;
  // inputFormatters
  final List<TextInputFormatter>? inputFormatters;

  final void Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.hintText = "",
    this.isPassword = false,
    this.keyboardType,
    this.inputFormatters = const [],
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      onChanged: onChanged,
      validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
      inputFormatters: inputFormatters,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(
            color: grayUfcat,
          ),
        ),
      ),
    );
  }
}
