import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightBlue,
        ).copyWith(
          secondary: Colors.indigoAccent[400],
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.deepPurpleAccent[400],
            textTheme: ButtonTextTheme.primary),
      ),
      home: DashBoard(),
    );
  }
}
