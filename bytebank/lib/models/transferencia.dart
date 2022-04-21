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

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }

}
