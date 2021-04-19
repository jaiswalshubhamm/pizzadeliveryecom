import 'package:flutter/material.dart';

void changeScreen(BuildContext context, String route) {
  Navigator.of(context).pushNamed(route);
}

void changeScreenReplacement(BuildContext context, String route) {
  Navigator.of(context).pushReplacementNamed(route);
}
