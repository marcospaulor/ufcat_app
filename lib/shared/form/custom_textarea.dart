import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importe esta biblioteca
import 'package:ufcat_app/theme/src/app_colors.dart';

class CustomTextArea extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final int maxLength; // Adicione esta propriedade
  final void Function(String)? onChanged;

  const CustomTextArea({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.maxLength, // Adicione esta propriedade
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomTextAreaState createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: 5, // Permite múltiplas linhas
      maxLength: widget.maxLength, // Define o limite de caracteres
      onChanged: widget.onChanged,
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
          RegExp(r'^[a-zA-Z0-9 ,.!?()]+$'), // Permitir letras, números, espaços, vírgula, ponto, exclamação e parênteses
        ),
      ],
      onTap: () {
        // Define a seleção inicial no início do texto
        final text = widget.controller.text;
        widget.controller.selection = TextSelection.collapsed(offset: text.length);
      },
      // Define a configuração do teclado para começar com a primeira letra maiúscula
      textCapitalization: TextCapitalization.sentences,
    );
  }

  @override
  void dispose() {
    widget.controller.dispose(); // Dispose do controlador de texto
    super.dispose();
  }
}
