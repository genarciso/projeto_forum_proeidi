import 'package:dio/dio.dart';

class NotificacaoRepository {
  static String urlbase = "http://localhost:8080/api/v1/notificacao";
  Response response;
  Dio dio = Dio();

  NotificacaoRepository({this.dio});
}