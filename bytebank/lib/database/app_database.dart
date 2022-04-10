import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase() {
  getDatabasesPath().then((dbPath){
    // Devolvendo a string com o caminho do bd
    final String path = join(dbPath, 'bytebank.db');
    // Abrindo e criando o bd
    openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
      db.execute('CREATE TABLE transfers('
          'id INTEGER PRIMARY KEY, '
          'value DOUBLE, '
          'account_number INTEGER)');
    }, version: 1);
  });
}