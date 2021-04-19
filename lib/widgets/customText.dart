import 'package:flutter/material.dart';
import '../config/palette.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final Color bgColor;
  final FontWeight weight;

  CustomText(
      {@required this.text, this.size, this.color, this.bgColor, this.weight});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '😢 Cant Get',
      style: TextStyle(
        fontSize: size ?? 16,
        color: color,
        fontWeight: weight ?? FontWeight.normal,
        backgroundColor: bgColor ?? Palette.transparent,
      ),
    );
  }
}
