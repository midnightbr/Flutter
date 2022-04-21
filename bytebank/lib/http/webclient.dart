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

void findAllTransaction() async {
  Client client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);
  // Chamando o get e atribuindo o valor a uma variavel
  final Response response =
      await client.get(Uri.http('192.168.1.7:8080', 'transactions'));
}
