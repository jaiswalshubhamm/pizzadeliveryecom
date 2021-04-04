import 'package:flutter/material.dart';
import '../config/palette.dart';

class LikeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Palette.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              offset: Offset(1, 1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(
            Icons.favorite_border,
            color: Palette.red,
            size: 18,
          ),
        ),
      ),
    );
  }
}
