class Contact {
  final String name;
  final int numberAccount;

  Contact(this.name, this.numberAccount);

  @override
  String toString() {
    return 'Contact{name: $name, numberAccount: $numberAccount}';
  }
}