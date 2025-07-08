import 'package:flutter/material.dart';
import 'package:random_color_page/pages/home_page.dart';


void main() {
  runApp(const Main());
}

///Main Widget
class Main extends StatelessWidget {
  const Main({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Test Task',
      home: HomePage(),
    );
  }
}
