import 'dart:convert';

import 'package:bytebank/models/contacts.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Request');
    print('URL: ${data.url}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Response');
    print('Status code: ${data.statusCode}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');
    return data;
  }
}

Future<List<Transaction>> findAllTransaction() async {
  Client client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);
  // Chamando o get e atribuindo o valor a uma variavel
  final Response response =
      await client.get(Uri.http('192.168.1.7:8080', 'transactions'));
  // Convertendo de json
  final List<dynamic> decodeJson = jsonDecode(response.body);
  // Lista de transações
  final List<Transaction> transactions = [];
  // Foreach para pegar os dados retornados do json
  for (Map<String, dynamic> transactionJson in decodeJson) {
    /**
     * Ao inves de transactionJson['contact']['name'], basta criar essa variavel
     * que toda vez que for chamada, ela dara acesso ao atributo contact da lista
      */
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    // Criando uma transferencia
    final Transaction transaction = Transaction(
      // Passando o valor
      transactionJson['value'],
      // Passando o contato da transferencia
      Contact(
        // Equivalente a transactionJson['contact']['name']
        contactJson['name'],
        // Equivalente a transactionJson['contact']['accountNumber']
        contactJson['accountNumber'],
        0,
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}
