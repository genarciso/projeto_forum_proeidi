import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/domain/pessoa.model.dart';

class PessoaRepository {
  static String urlbase = "http://localhost:8080/api/v1/pessoa";
  Response response;
  Dio dio = Dio();


  PessoaRepository({this.dio});

  Future<List<PessoaModel>> buscarTodos() async {
    response = await dio.get(urlbase);
    return (response.data as List).map((item) => PessoaModel.fromJson(item)).toList();
  }

  Future<PessoaModel> buscarUm(num idPessoa) async {
    response = await dio.get(urlbase);
    return PessoaModel.fromJson(response.data);
  }

  void salvar(PessoaModel pessoaModel) async {
    try {
      await dio.post(urlbase, data: pessoaModel.toJson());
    } on DioError catch (err) {
      print("Erro ao realizar o cadastro: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void editar(PessoaModel pessoaModel) async {
    try {
      await dio.put(urlbase , data: pessoaModel.toJson());
    } on DioError catch (err) {
      print("Erro ao realizar a edição: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void deletar(PessoaModel pessoaModel) async {
    try {
      await dio.delete(urlbase + "/${pessoaModel.id}");
    } on DioError catch (err) {
      print("Erro ao realizar a remoção: ${err.response.statusCode} | ${err.response.data} ");
    }
  }
}