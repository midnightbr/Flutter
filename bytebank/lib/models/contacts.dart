class Contact {
  final int? id;
  late final String name;
  late final int accountNumber;

  Contact(this.name, this.accountNumber, this.id);

  // Convertendo de JSON
  Contact.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        accountNumber = json['accountNumber'];

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, numberAccount: $accountNumber}';
  }

  // Convertendo para JSON
  Map<String, dynamic> toJson() => {
    'name' : name,
    'accountNumber' : accountNumber,
  };
}
