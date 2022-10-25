import 'package:flutter/material.dart';
import 'package:ufcat_app/view/const.dart';

class CardButton extends StatelessWidget {
  final String title;
  final String imagePath;

  const CardButton({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 5,
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: SizedBox(
          width: 318,
          height: 186,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 108,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    fit: BoxFit.cover,
                    imagePath,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                alignment: Alignment.center,
                height: 78,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: darkUfcat,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildCards(String title, List<CardButton> cards) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            left: 20.0,
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: darkUfcat,
              fontSize: 16,
            ),
          ),
        ),
        ListView(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 20.0,
          ),
          children: cards,
        ),
      ],
    );
  }
}
