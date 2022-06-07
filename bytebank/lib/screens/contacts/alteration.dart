import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:flutter/material.dart';

// Atributos constantes
const _tituloAppBar = 'Alteration contact';
const _rotuloContact = 'Full name';
const _rotuloAccount = 'Account number';
const _button = 'Alteration';

class AlterationContact extends StatefulWidget {
  final Contact contact;

  AlterationContact(this.contact);

  @override
  State<AlterationContact> createState() => _AlterationContactState();
}

class _AlterationContactState extends State<AlterationContact> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _tituloAppBar,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.contact.name,
              decoration: InputDecoration(labelText: 'Name'),
              onSaved: (value) => widget.contact.name = value!,
            ),
            TextFormField(
              initialValue: widget.contact.accountNumber.toString(),
              decoration: InputDecoration(labelText: 'Account Number'),
              onSaved: (value) =>
                  widget.contact.accountNumber = int.parse(value!),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite, // Preenchendo toda a tela
                child: ElevatedButton(
                  onPressed: () {
                    final String name = widget.contact.name;
                    final int? numberAccount = widget.contact.accountNumber;
                    final Contact updateContact =
                        Contact(name, numberAccount!, 0);
                    _dao
                        .updateContact(updateContact)
                        .then((id) => Navigator.pop(context));
                  },
                  child: Text(
                    _button,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
