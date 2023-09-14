import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget? child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xff0c0f30),
            Color(0xffa21e50),
          ],
        ),
      ),
      child: child,
    );
  }
}
