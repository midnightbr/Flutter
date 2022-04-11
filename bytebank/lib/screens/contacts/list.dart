import 'package:bytebank/models/contacts.dart';
import 'package:bytebank/screens/contacts/form.dart';
import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  final List<Contact> contacts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contacts',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          // Recebendo os itens dentro da lista
          final Contact contact = contacts[index];
          // Retornando os itens para a classe contactItem para a construção
          return _ContactItem(contact);
        },
        itemCount: contacts.length,
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

class _ContactItem extends StatelessWidget {
  final Contact contact;

  // Recebendo o contato da lista
  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    // Criando a listagem dos itens da lista recebido pelo construtor
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.numberAccount.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
