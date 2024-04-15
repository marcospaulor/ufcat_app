import 'package:flutter/material.dart';

class StickyButton extends StatefulWidget {
  final String label;
  final Color color;
  final double size;
  final Function() onPressed;

  const StickyButton({
    super.key,
    required this.label,
    required this.color,
    required this.size,
    required this.onPressed,
  });

  @override
  State<StickyButton> createState() => _StickyButtonState();
}

class _StickyButtonState extends State<StickyButton> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(width * widget.size, 50),
          backgroundColor: widget.color,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
        ),
        onPressed: widget.onPressed,
        child: Text(widget.label,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: Colors.white)),
      ),
    );
  }
}
