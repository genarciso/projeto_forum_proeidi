import 'package:dio/dio.dart';
import 'package:projeto_forum_proeidi/domain/pessoa.model.dart';
import 'package:projeto_forum_proeidi/repository/abstract.repository.dart';

class PessoaRepository extends AbstractRepository {
  static String urlbase = AbstractRepository.urlbase + "/pessoa";
  Dio _dio = Dio();

  Future<List<PessoaModel>> buscarTodos() async {
    response = await _dio.get(urlbase);
    return (response.data as List).map((item) => PessoaModel.fromJson(item)).toList();
  }

  Future<PessoaModel> buscarUm([num idPessoa]) async {
    if (idPessoa != null) {
      response = await _dio.get(urlbase + "/$idPessoa");
      return PessoaModel.fromJson(response.data);
    } else {
      return null;
    }
  }

  void salvar(PessoaModel pessoaModel) async {
    try {
      await _dio.post(urlbase, data: pessoaModel.toJson());
    } on DioError catch (err) {
      print("Erro ao realizar o cadastro: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void editar(PessoaModel pessoaModel) async {
    try {
      await _dio.put(urlbase , data: pessoaModel.toJson());
    } on DioError catch (err) {
      print("Erro ao realizar a edição: ${err.response.statusCode} | ${err.response.data} ");
    }
  }

  void deletar(PessoaModel pessoaModel) async {
    try {
      await _dio.delete(urlbase + "/${pessoaModel.id}");
    } on DioError catch (err) {
      print("Erro ao realizar a remoção: ${err.response.statusCode} | ${err.response.data} ");
    }
  }
}