import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ufcat_app/theme/src/app_colors.dart';

class StarRating extends StatefulWidget {
  final double padding;
  final double size;
  final int rating = 3;
  final ValueChanged<int>? onRatingChanged;
  final bool allowRating;

  const StarRating({
    Key? key,
    required this.padding,
    required this.size,
    required this.allowRating,
    this.onRatingChanged,
  }) : super(key: key);

  @override
  State<StarRating> createState() => StarRatingState();
}

class StarRatingState extends State<StarRating> {
  int stateRating = 0;

  @override
  void initState() {
    super.initState();
    stateRating = widget.rating;
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: 3,
      minRating: 1,
      maxRating: 5,
      direction: Axis.horizontal,
      ignoreGestures: !widget.allowRating,
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
          stateRating = rating.toInt();
        });
        if (widget.onRatingChanged != null) {
          widget.onRatingChanged!(rating.toInt());
        }
      },
    );
  }
}
