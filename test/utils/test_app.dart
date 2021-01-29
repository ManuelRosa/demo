import 'package:flutter/material.dart';

class TestApp extends StatelessWidget {
  const TestApp(this.widget);

  final Widget widget;

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: widget,
        ),
      );
}
