import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class StarRating extends StatefulWidget {
  final double padding;
  final double size;
  int _rating = 0;

  StarRating({
    Key? key,
    required this.padding,
    required this.size,
  }) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: 3,
      minRating: 1,
      maxRating: 5,
      direction: Axis.horizontal,
      ignoreGestures: widget.size == 20.0 ? true : false,
      allowHalfRating: false,
      itemCount: 5,
      itemSize: widget.size,
      itemPadding: EdgeInsets.symmetric(horizontal: widget.padding),
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
          widget._rating = rating.toInt();
        });
      },
    );
  }
}
