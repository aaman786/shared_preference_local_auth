import 'package:flutter/material.dart';

class BuildTitleWithChild extends StatelessWidget {
  final String title;
  final Widget child;
  const BuildTitleWithChild(
      {super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              fontSize: 14),
        ),
        const SizedBox(height: 02),
        child,
      ],
    );
    ;
  }
}
