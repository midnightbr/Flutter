import 'package:bytebank/screens/contacts/form.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacts',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text(
                'Marcos',
                style: TextStyle(fontSize: 24.0),
              ),
              subtitle: Text(
                '13579',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => ContactForm(),
                ),
              )
              .then(
                (newContact) => debugPrint(newContact.toString()),
              );
        },
        child: Icon(
          Icons.person_add_alt_1,
        ),
      ),
    );
  }
}
