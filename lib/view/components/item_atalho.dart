import 'package:flutter/material.dart';

class AtalhoIcon extends StatelessWidget {
  const AtalhoIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/news');
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15),
            ),
            child: Icon(icon, size: 40),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
