import 'package:flutter/material.dart';
import 'package:ufcat_app/view/const.dart';

class AtalhoIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const AtalhoIcon({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).padding.top,
        horizontal: 5.0,
      ),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/news');
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(15.0),
              ),
              child: Icon(icon, size: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                text,
                style: const TextStyle(color: greenUfcat),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
