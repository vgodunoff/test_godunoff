import 'package:flutter/material.dart';
import 'package:test_godunoff/screens/list_users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Users(),
    );
  }
}
