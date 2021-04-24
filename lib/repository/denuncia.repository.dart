import 'package:dio/dio.dart';

class DenunciaRepository {
  static String urlbase = "http://localhost:8080/api/v1/denuncia";
  Response response;
  Dio dio = Dio();

  DenunciaRepository({this.dio});
}