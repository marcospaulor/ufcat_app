import 'package:flutter/material.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool isRequired; // Controle de validação
  final bool isEmail;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText = "",
    this.isPassword = false,
    this.keyboardType,
    this.inputFormatters = const [],
    this.onChanged,
    this.isRequired = true, // Validação padrão
    this.isEmail = false,
  });

  String? emailValidator(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value!)) return 'Por favor, insira um email válido';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      onChanged: onChanged,
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) return 'Campo obrigatório';

        if(isEmail) return emailValidator(value);

        return null;
      },
      inputFormatters: inputFormatters, // Adiciona suporte a inputFormatters
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
