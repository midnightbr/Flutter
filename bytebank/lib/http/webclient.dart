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

const String urlBase = '192.168.1.7:8080';

final Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);

Future<List<Transaction>> findAllTransaction() async {
  // Chamando o get e atribuindo o valor a uma variavel
  final Response response = await client
      .get(Uri.http(urlBase, 'transactions'))
      .timeout(Duration(seconds: 10));
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

Future<Transaction> saveTransfer(Transaction transaction) async {
  // Mapeando objetos para converter para json
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };

  // Convertendo objetos para json
  final String transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(
    Uri.http(urlBase, 'transactions'),
    headers: {
      'Content-type': 'application/json',
      'password': '1000',
    },
    body: transactionJson,
  );

  // Pegando o response (retorno) do post
  Map<String, dynamic> json = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = json['contact'];
  return Transaction(json['value'], Contact(
    contactJson['name'],
    contactJson['accountNumber'],
    0
  ));
}
