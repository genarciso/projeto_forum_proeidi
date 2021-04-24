import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/domain/topico_forum.model.dart';

class TopicoForumRepository {
  static String urlbase = "http://localhost:8080/api/v1/topico-forum";
  Response response;
  Dio dio = Dio();


  TopicoForumRepository({this.dio});

  Future<List<TopicoForumModel>> buscarTodos() async {
    response = await dio.get(urlbase);
    return (response.data as List).map((item) => TopicoForumModel.fromJson(item)).toList();
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