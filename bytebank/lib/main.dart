// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('100,00'),
              subtitle: Text('100.00'),
            ),
          ),
        ],
      ),
      appBar: AppBar(title: Text('Transferências'),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.add),
      ),
    ),
  ));
}
