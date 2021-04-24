import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';

class RespostaModel {
  final num id;
  final String resposta;
  final DateTime dataCriado;
  final DateTime dataUltimaEdicao;
  final TipoDTO<num> pessoaCadastro;
  final TipoDTO<num> pessoaUltimaEdicao;
  final TipoDTO<num> duvida;
  int likes;
  int dislikes;

  RespostaModel({
    this.id,
    this.resposta,
    this.dataCriado,
    this.dataUltimaEdicao,
    this.pessoaCadastro,
    this.pessoaUltimaEdicao,
    this.duvida,
    this.likes,
    this.dislikes
  });

  factory RespostaModel.fromJson(Map<String, dynamic> json) => RespostaModel(
    id: json["id"],
    resposta: json["resposta"],
    dataCriado: json["dataCriado"],
    dataUltimaEdicao: json["dataUltimaEdicao"],
    pessoaCadastro: TipoDTO.fromJson(json["pessoaCadastro"]),
    pessoaUltimaEdicao: TipoDTO.fromJson(json["pessoaUltimaEdicao"]),
    duvida: TipoDTO.fromJson(json["duvida"]),
    likes: json["likes"],
    dislikes: json["dislikes"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "resposta": resposta,
    "dataCriado": dataCriado,
    "dataUltimaEdicao": dataUltimaEdicao,
    "pessoaCadastro": pessoaCadastro.toJson(),
    "pessoaUltimaEdicao": pessoaUltimaEdicao.toJson(),
    "duvida": duvida.toJson(),
    "likes": likes,
    "dislikes": dislikes
  };

  @override
  String toString() {
    return '$resposta';
  }
}
