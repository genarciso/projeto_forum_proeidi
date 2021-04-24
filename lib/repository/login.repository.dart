import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/domain/autenticao.model.dart';

class LoginRepository {
  static String urlbase = "http://localhost:8080/api/v1/auth";
  Response response;
  Dio dio = Dio();

  LoginRepository({this.dio});

  Future<AutenticacaoModel> autenticar(String login, String senha) async {
    try {
      await dio.post(urlbase + "?login=$login&password=$senha");
    } on DioError catch(err) {
      print("Erro ao realizar o cadastro: ${err.response.statusCode} | ${err.response.data} ");
    }
  }
}