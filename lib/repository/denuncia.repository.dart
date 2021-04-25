import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/domain/denuncia.model.dart';
import 'package:projeto_forum_proeidi/repository/abstract.repository.dart';

class DenunciaRepository extends AbstractRepository {
  static String urlbase = AbstractRepository.urlbase + "/denuncia";

  Future<Response> denunciar(DenunciaModel denunciaModel) async {
    try {
      return await dio.post(urlbase, data: denunciaModel.toJson());
    } on DioError catch (err) {
      print("Erro ao realizar o cadastro: ${err}");
      return Response(requestOptions: null, statusCode: err.response.statusCode);
    }
  }
}