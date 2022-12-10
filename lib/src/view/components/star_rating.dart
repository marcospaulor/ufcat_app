import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/src/view/style/const.dart';

class StarRating extends StatefulWidget {
  const StarRating({Key? key}) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: 3,
      minRating: 0,
      maxRating: 5,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemSize: 20.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 6.0),
      ratingWidget: RatingWidget(
        full: const Icon(
          FontAwesomeIcons.solidStar,
          color: orangeUfcat,
        ),
        half: const Icon(
          FontAwesomeIcons.solidStarHalfStroke,
          color: orangeUfcat,
        ),
        empty: const Icon(
          FontAwesomeIcons.star,
          color: orangeUfcat,
        ),
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating.toInt();
        });
      },
    );
    // RatingBar.builder(
    //   initialRating: 3,
    //   minRating: 1,
    //   maxRating: 5,
    //   direction: Axis.horizontal,
    //   allowHalfRating: false,
    //   itemCount: 5,
    //   itemPadding: EdgeInsets.symmetric(
    //     horizontal: 4,
    //   ),
    //   itemBuilder: (context, _) => Icon(
    //     FontAwesomeIcons.star,
    //     color: orangeUfcat,
    //   ),
    //   onRatingUpdate: (rating) {
    //     setState(() {
    //       _rating = rating.toInt();
    //     });
    //   },
    // );
  }
}
