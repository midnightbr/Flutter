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
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
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
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
