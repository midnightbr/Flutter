import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAllTransaction() async {
    // Chamando o get e atribuindo o valor a uma variavel
    final Response response =
        await client.get(Uri.http(urlBase, 'transactions'));
    // Convertendo de json
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> saveTransfer(
      Transaction transaction, String password) async {
    // Convertendo objetos para JSON
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 10));

    final Response response = await client.post(
      Uri.http(urlBase, 'transactions'),
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      // Pegando o response (retorno) do post
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String? _getMessage(int statusCode) {
    if (_statusCodeResponse.containsKey(statusCode)) {
      return _statusCodeResponse[statusCode];
    }
    else {
      return 'Unknown error';
    }
  }

  static final Map<int, String> _statusCodeResponse = {
    400: 'There was an error submitting transaction!',
    401: 'Authenticator failed!',
    409: 'Transaction already exist!'
  };
}

class HttpException implements Exception {
  final String? message;

  HttpException(this.message);
}
