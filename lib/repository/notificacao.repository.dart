import 'package:dio/dio.dart';

class NotificacaoRepository {
  static String urlbase = "http://10.0.1.109:8080/api/v1";
  Response response;
  Dio dio = Dio();

  NotificacaoRepository({this.dio});
}
