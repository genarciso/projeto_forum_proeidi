import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/repository/abstract.repository.dart';

class LoginRepository extends AbstractRepository {
  static String urlbase = AbstractRepository.urlbase + "/auth";
  Dio _dio = Dio();

  Future<Response> autenticar(String login, String senha) async {
    try {
      response = await _dio.post(urlbase + "/login?login=$login&password=$senha");
      return response;
    } on DioError catch(err) {
      return Response(requestOptions: null, statusCode: err.response.statusCode);
    }
  }
}