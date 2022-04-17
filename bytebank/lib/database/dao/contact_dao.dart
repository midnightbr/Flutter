import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contacts.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  Future<int> saveContact(Contact contact) async {
    // Método com async await (sintaxe sugar)
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert(_tableName, contactMap);

    // -> Método sem o await
    // return createDatabase().then((db) {
    //   /**
    //    * Para conseguir inserir os dados no bd do sql lite é preciso mapealas
    //    * já que o método recebe um map dynamic e não os dados diretos
    //    */
    //   final Map<String, dynamic> contactMap = Map();
    //   // contactMap['id'] = contact.id; -> sqlite auto encrementa
    //   contactMap['name'] = contact.name;
    //   contactMap['account_number'] = contact.numberAccount;
    //   // Adicionado o return para retorna se o id foi inserido
    //   return db.insert('contacts', contactMap);
    // });
  }

  Future<List<Contact>> findAllContacts() async {
    // -> Método com o async await (sintaxe sugar)
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Contact> contacts = _toList(result);
    return contacts;

    // -> Método sem o async await
    // return getDatabase().then((db) {
    //   return db.query('contacts').then((maps) {
    //     // Iniciando uma lista dos contatos
    //     final List<Contact> contacts = [];
    //     // Criando um foreach para passar por todos os dados da tabela
    //     for (Map<String, dynamic> map in maps) {
    //       final Contact contact = Contact(
    //         map['name'],
    //         map['account_number'],
    //         map['id'],
    //       );
    //       contacts.add(contact);
    //     }
    //     return contacts;
    //   });
    // });
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.numberAccount;
    return contactMap;
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> row in result) {
      final Contact contact =
      Contact(row[_name], row[_accountNumber], row[_id]);
      contacts.add(contact);
    }
    return contacts;
  }
}