import 'package:flutter/material.dart';
import './ui/homePage.dart';

main() {
  runApp(
    MaterialApp(
      home: HomePage(),
      theme: ThemeData(hintColor: Colors.white),
    ),
  );
}
