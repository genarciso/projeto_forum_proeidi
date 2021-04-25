import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/domain/resposta.model.dart';
import 'package:projeto_forum_proeidi/repository/abstract.repository.dart';

class RespostaRepository extends AbstractRepository {
  static String urlbase = AbstractRepository.urlbase + "/resposta";


  Future<List<RespostaModel>> buscarTodos(num idDuvida) async {
    try {
      response = await dio.get(urlbase + "?id_related=$idDuvida");
    } on DioError catch (err) {
      print("Erro ao pesquisar os topico: ${err.response.statusCode} | ${err.response.data} ");
    }
    print((response.data["conteudo"] as List).map((item) => RespostaModel.fromJson(item)).toList());
    return (response.data["conteudo"] as List).map((item) => RespostaModel.fromJson(item)).toList();
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