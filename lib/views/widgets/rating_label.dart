import 'package:flutter/material.dart';

class RatingLabel extends StatelessWidget {
  const RatingLabel(this.rating, {super.key, this.size = 13});
  final String rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: Colors.amber, size: size + 3),
        const SizedBox(width: 3),
        Text(rating, style: TextStyle(fontSize: size)),
      ],
    );
  }
}
