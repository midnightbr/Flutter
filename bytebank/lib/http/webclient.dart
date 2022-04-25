import 'package:bytebank/http/interceptors/logging_interceptors.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

const String urlBase = '192.168.1.7:8080';

final Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor(),
]);
