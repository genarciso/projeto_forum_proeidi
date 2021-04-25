import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/domain/topico_forum.model.dart';
import 'package:projeto_forum_proeidi/repository/abstract.repository.dart';

class TopicoForumRepository extends AbstractRepository {
  static String urlbase = AbstractRepository.urlbase + "/topico-forum";

  Future<List<TopicoForumModel>> buscarTodos() async {
    try {
      response = await dio.get(urlbase);
    } on DioError catch (err) {
      print("Erro ao pesquisar os topico: ${err.response.statusCode} | ${err.response.data} ");
    }

    return (response.data["conteudo"] as List).map((item) => TopicoForumModel.fromJson(item)).toList();
  }

  void salvar(TopicoForumModel topicoForumModel) async {
    try {
      await dio.post(urlbase, data: topicoForumModel.toJson());
    } on DioError catch (err) {
      print("Erro ao realizar o cadastro: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void editar(TopicoForumModel topicoForumModel) async {
    try {
      await dio.put(urlbase , data: topicoForumModel.toJson());
    } on DioError catch (err) {
      print("Erro ao realizar a edição: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void deletar(TopicoForumModel topicoForumModel) async {
    try {
      await dio.delete(urlbase + "/${topicoForumModel.id}");
    } on DioError catch (err) {
      print("Erro ao realizar a remoção: ${err.response.statusCode} | ${err.response.data} ");
    }
  }
}