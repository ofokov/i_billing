import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(height: 24, width: 24),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: <Color>[
            Color(0xFF00FFC2),
            Color(0xFF0500FF),
            Color(0xFFFFC700),
            Color(0xFFAD00FF),
            Color(0xFF00FF94),
          ],
        ),
      ),
    );
  }
}
