import 'package:bytebank/models/contacts.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  // Método com async await (sintaxe sugar)
  /**
   * Ele remove a necessidade dos .then e podemos colocar o getDatabasesPath
   * dentro do path, já que o await segura a execução até que o getDatabasesPath
   * esteja concluido.
   */
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      // Criando tabela Contacts
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
      // Criando tabela Transfers
      db.execute('CREATE TABLE transfers('
          'id INTEGER PRIMARY KEY, '
          'value DOUBLE, '
          'account_number INTEGER)');
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,//-> utilizado para apagar o bd
  );

  // // -> Método sem o await
  // // Retornando a feature com os dados da feature openDatabase
  // return getDatabasesPath().then((dbPath) {
  //   // Devolvendo a string com o caminho do bd
  //   final String path = join(dbPath, 'bytebank.db');
  //   // Abrindo e criando o bd
  //   // Colocado o return para retorna a feature para pegar o valor do bd
  //   return openDatabase(path, onCreate: (db, version) {
  //     // Criando tabela Contacts
  //     db.execute('CREATE TABLE contacts('
  //         'id INTEGER PRIMARY KEY, '
  //         'name TEXT, '
  //         'account_number INTEGER)');
  //     // Criando tabela Transfers
  //     db.execute('CREATE TABLE transfers('
  //         'id INTEGER PRIMARY KEY, '
  //         'value DOUBLE, '
  //         'account_number INTEGER)');
  //   }, version: 1,
  //      // onDowngrade: onDatabaseDowngradeDelete,//-> utilizado para apagar o bd
  //   );
  // });
}

Future<int> saveContact(Contact contact) async {
  // Método com async await (sintaxe sugar)
  final Database db = await getDatabase();
  final Map<String, dynamic> contactMap = Map();
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.numberAccount;
  return db.insert('contacts', contactMap);

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

Future<int> saveTransfer(Transferencia transferencia) async {
  // -> Método com o async await (sintaxe sugar)
  final Database db = await getDatabase();
  final Map<String, dynamic> transferMap = Map();
  transferMap['value'] = transferencia.value;
  transferMap['account_number'] = transferencia.numberAccount;
  return db.insert('transfers', transferMap);

  // -> Método sem o await
  // return getDatabase().then((db) {
  //   final Map<String, dynamic> transferMap = Map();
  //   transferMap['value'] = transferencia.value;
  //   transferMap['account_number'] = transferencia.numberAccount;
  //   return db.insert('transfers', transferMap);
  // });
}

Future<List<Contact>> findAllContacts() async {
  // -> Método com o async await (sintaxe sugar)
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> result = await db.query('contacts');
  final List<Contact> contacts = [];
  for (Map<String, dynamic> row in result) {
    final Contact contact =
        Contact(row['name'], row['account_number'], row['id']);
    contacts.add(contact);
  }
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

Future<List<Transferencia>> findAllTransfers() async {
  // -> Método com async await (sintaxe sugar)
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> result = await db.query('transfers');
  final List<Transferencia> transfers = [];
  for (Map<String, dynamic> row in result) {
    final Transferencia transfer = Transferencia(
      row['value'],
      row['account_number'],
      row['id'],
    );
    transfers.add(transfer);
  }
  return transfers;

  // -> Método sem async await
  // return getDatabase().then((db) {
  //   return db.query('transfers').then((maps) {
  //     final List<Transferencia> transfers = [];
  //     for (Map<String, dynamic> map in maps) {
  //       final Transferencia transfer = Transferencia(
  //         map['value'],
  //         map['account_number'],
  //         map['id'],
  //       );
  //       transfers.add(transfer);
  //     }
  //     return transfers;
  //   });
  // });
}
