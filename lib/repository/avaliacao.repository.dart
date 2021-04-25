import 'package:dio/dio.dart';

class AvaliacaoRepository {
  static String urlbase = "http://localhost:8080/api/v1/avaliacao";
  Response response;
  Dio dio = Dio();

  AvaliacaoRepository({this.dio});
}