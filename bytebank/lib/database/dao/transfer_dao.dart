import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:sqflite/sqflite.dart';

class TransferDao {
  static const _tableName = 'transfers';
  static const _id = 'id';
  static const _value = 'value';
  static const _accountNumber = 'account_number';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_value DOUBLE, '
      '$_accountNumber INTEGER)';

  Future<int> saveTransfer(Transferencia transferencia) async {
    // -> Método com o async await (sintaxe sugar)
    final Database db = await getDatabase();
    Map<String, dynamic> transferMap = _toMap(transferencia);
    return db.insert(_tableName, transferMap);

    // -> Método sem o await
    // return getDatabase().then((db) {
    //   final Map<String, dynamic> transferMap = Map();
    //   transferMap['value'] = transferencia.value;
    //   transferMap['account_number'] = transferencia.numberAccount;
    //   return db.insert('transfers', transferMap);
    // });
  }

  Future<List<Transferencia>> findAllTransfers() async {
    // -> Método com async await (sintaxe sugar)
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Transferencia> transfers = _toList(result);
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

  Future<int> updateTransfer(Transferencia transferencia) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> transferMap = _toMap(transferencia);
    return db.update(
      _tableName,
      transferMap,
      where: '$_id = ?',
      whereArgs: [transferencia.id],
    );
  }

  Future<int> deleteTransfer(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [id],
    );
  }

  Map<String, dynamic> _toMap(Transferencia transferencia) {
    final Map<String, dynamic> transferMap = Map();
    transferMap[_value] = transferencia.value;
    transferMap[_accountNumber] = transferencia.numberAccount;
    return transferMap;
  }

  List<Transferencia> _toList(List<Map<String, dynamic>> result) {
    final List<Transferencia> transfers = [];
    for (Map<String, dynamic> row in result) {
      final Transferencia transfer = Transferencia(
        row[_value],
        row[_accountNumber],
        row[_id],
      );
      transfers.add(transfer);
    }
    return transfers;
  }
}
