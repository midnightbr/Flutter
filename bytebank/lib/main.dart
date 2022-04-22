import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
  saveTransfer(Transaction(200.00, Contact('João', 2000, 0)))
      .then((transaction) => print(transaction));
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightBlue,
        ).copyWith(
          secondary: Colors.blue[700],
        ),
        buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue[700], textTheme: ButtonTextTheme.primary),
      ),
      home: DashBoard(),
    );
  }
}
