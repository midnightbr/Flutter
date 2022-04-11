class Contact {
  final int id;
  final String name;
  final int numberAccount;

  Contact(this.name, this.numberAccount, this.id);

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, numberAccount: $numberAccount}';
  }
}