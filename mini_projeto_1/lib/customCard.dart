import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String category;
  final double imcValue;

  CustomCard({required this.backgroundColor, required this.textColor, required this.category, required this.imcValue});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
            Text(
              'IMC',
              style: TextStyle(fontSize: 36, color: textColor, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              category,
              style: TextStyle(fontSize: 24, color: textColor),
              textAlign: TextAlign.center,
            ),
            Text(
              imcValue.toStringAsFixed(2),
              style: TextStyle(fontSize: 24, color: textColor, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
        ]),
      ),
    );
  }
}
