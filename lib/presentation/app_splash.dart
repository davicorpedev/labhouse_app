import 'package:flutter/material.dart';
import 'package:labhouse_app/presentation/widgets/background.dart';

class AppSplash extends StatelessWidget {
  final Widget? child;

  const AppSplash({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: child,
      ),
    );
  }
}
