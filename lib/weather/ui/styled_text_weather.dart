
import 'package:flutter/material.dart';

class WeatherText extends StatelessWidget {
  final String text;
  const WeatherText({super.key,
  required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: const TextStyle(
      fontSize: 20,
    ),);
  }
}
