import 'package:dio/dio.dart';

class AbstractRepository {
  static String urlbase = "http://192.168.1.12:8080/api/v1";
  Response response;
  Dio dio = Dio();
}
