import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class CustomTextArea extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final int maxLength;
  final void Function(String)? onChanged;
  final bool isRequired; // Controle de validação

  const CustomTextArea({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.maxLength,
    this.onChanged,
    this.isRequired = true, // Validação padrão
  });

  @override
  CustomTextAreaState createState() => CustomTextAreaState();
}

class CustomTextAreaState extends State<CustomTextArea> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: 5,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      validator: widget.isRequired
          ? (value) => value!.isEmpty ? 'Campo obrigatório' : null
          : null,
      style: Theme.of(context).textTheme.bodyLarge,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        hintText: widget.hintText,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          borderSide: BorderSide(color: grayUfcat),
        ),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^[\p{L}\p{N} ,.!?()]+$', unicode: true)),
      ], // Adiciona suporte a inputFormatters
      onTap: () {
        final text = widget.controller.text;
        widget.controller.selection =
            TextSelection.collapsed(offset: text.length);
      },
      textCapitalization: TextCapitalization.sentences,
    );
  }
}
