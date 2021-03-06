import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/domain/duvida.model.dart';
import 'package:projeto_forum_proeidi/repository/abstract.repository.dart';

class DuvidaRepository extends AbstractRepository {
  static String urlbase = AbstractRepository.urlbase + "/duvida";

  Future<List<DuvidaModel>> buscarTodos(num idTopico) async {
    try {
      response = await dio.get(urlbase + "?id_related=$idTopico");
    } on DioError catch (err) {
      print(
          "Erro ao pesquisar as duvidas: ${err.response.statusCode} | ${err.response.data} ");
    }
    return (response.data["conteudo"] as List)
        .map((item) => DuvidaModel.fromJson(item))
        .toList();
  }

  void salvar(DuvidaModel duvidaModel) async {
    try {
      await dio.post(urlbase, data: duvidaModel.toJson());
    } on DioError catch (err) {
      print(
          "Erro ao realizar o cadastro: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void editar(DuvidaModel duvidaModel) async {
    try {
      await dio.put(urlbase, data: duvidaModel.toJson());
    } on DioError catch (err) {
      print(
          "Erro ao realizar a edição: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void deletar(DuvidaModel duvidaModel) async {
    try {
      await dio.delete(urlbase + "/${duvidaModel.id}");
    } on DioError catch (err) {
      print(
          "Erro ao realizar a remoção: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void marcarComoRespondida(DuvidaModel duvidaModel, num idResposta) async {
    try {
      await dio.post(urlbase +
          "/${duvidaModel.id}/marcar-como-respondida?id_resposta=$idResposta");
    } on DioError catch (err) {
      print(
          "Erro ao realizar a marcação: ${err.response.statusCode} | ${err.response.data} ");
    }
  }
}
