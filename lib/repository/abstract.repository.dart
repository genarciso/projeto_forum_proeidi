import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/repository/interceptors/customDio.dart';

class AbstractRepository {
  static String urlbase = "http://10.0.1.109:8080/api/v1";
  Response response;
  CustomDIO dio = CustomDIO();
}
