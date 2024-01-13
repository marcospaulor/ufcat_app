import 'package:flutter/material.dart';

class ContainerRu extends StatelessWidget {
  const ContainerRu({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: width * 0.4,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: width * 0.5,
              alignment: Alignment.center,
              child: Text(
                title,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Container(
              width: width * 0.55,
              alignment: Alignment.center,
              child: Text(
                content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
