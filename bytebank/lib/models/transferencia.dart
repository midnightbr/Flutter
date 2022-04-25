import 'package:bytebank/models/contacts.dart';

class Transferencia {
  final int id;
  final double value;
  final int numberAccount;

  Transferencia(this.value, this.numberAccount, this.id);

  @override
  String toString() {
    return 'Transferencia{value: $value, numberAccount: $numberAccount}';
  }
}

class Transaction {
  final double value;
  final Contact contact;

  Transaction(
    this.value,
    this.contact,
  );

  // Convertendo de JSON
  Transaction.fromJson(Map<String, dynamic> json) :
        value = json['value'],
        contact = Contact.fromJson(json['contact']);

  // Convertendo para JSON
  Map<String, dynamic> toJson() => {
    'value' : value,
    'contact' : contact.toJson(),
  };

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }
}
