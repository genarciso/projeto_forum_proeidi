import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/domain/resposta.model.dart';

class RespostaRepository {
  static String urlbase = "http://localhost:8080/api/v1/resposta";
  Response response;
  Dio dio = Dio();


  RespostaRepository({this.dio});

  Future<List<RespostaModel>> buscarTodos(num idDuvida) async {
    response = await dio.get(urlbase + "?id_related=$idDuvida");
    return (response.data as List).map((item) => RespostaModel.fromJson(item)).toList();
  }

  void salvar(RespostaModel respostaModel) async {
    try {
      await dio.post(urlbase, data: respostaModel.toJson());
    } on DioError catch (err) {
      print("Erro ao realizar o cadastro: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void editar(RespostaModel respostaModel) async {
    try {
      await dio.put(urlbase , data: respostaModel.toJson());
    } on DioError catch (err) {
      print("Erro ao realizar a edição: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void deletar(RespostaModel respostaModel) async {
    try {
      await dio.delete(urlbase + "/${respostaModel.id}");
    } on DioError catch (err) {
      print("Erro ao realizar a remoção: ${err.response.statusCode} | ${err.response.data} ");
    }
  }
}