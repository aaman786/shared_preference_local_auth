import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const TitleWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Icon(icon, size: 100),
          const SizedBox(height: 02),
          Text(
            text,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 34,
                letterSpacing: 2,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ],
      );
}
