import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAllTransaction() async {
    // Chamando o get e atribuindo o valor a uma variavel
    final Response response = await client
        .get(Uri.http(urlBase, 'transactions'))
        .timeout(Duration(seconds: 10));
    // Convertendo de json
    List<Transaction> transactions = _convertJsonForDart(response);
    return transactions;
  }

  Future<Transaction> saveTransfer(Transaction transaction) async {
    // Convertendo objetos para JSON
    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response = await client.post(
      Uri.http(urlBase, 'transactions'),
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transactionJson,
    );

    // Pegando o response (retorno) do post
    return _convertDartForJson(response);
  }

  // Convertendo os dados de JSON para uma Lista
  List<Transaction> _convertJsonForDart(Response response) {
    final List<dynamic> decodeJson = jsonDecode(response.body);
    // Lista de transações
    final List<Transaction> transactions = [];
    // Foreach para pegar os dados retornados do json
    for (Map<String, dynamic> transactionJson in decodeJson) {
      // Convertendo JSON para Dart
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  Transaction _convertDartForJson(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return Transaction.fromJson(json);
  }
}