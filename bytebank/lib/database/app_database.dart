import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/database/dao/transfer_dao.dart';
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
      db.execute(ContactDao.tableSql);
      // Criando tabela Transfers
      db.execute(TransferDao.tableSql);
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