import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';

class TopicoForumModel extends TipoDTO<num>{
  final String descricao;
  final DateTime dataCriado;
  final TipoDTO<num> pessoaCadastro;
  List<TipoDTO<dynamic>> tags;

  TopicoForumModel({
    id,
    nome,
    this.descricao,
    this.dataCriado,
    this.pessoaCadastro,
    this.tags
  }) : super(id: id, nome: nome) ;

  factory TopicoForumModel.fromJson(Map<String, dynamic> json) => TopicoForumModel(
      id: json["id"],
      nome: json["nome"],
      descricao: json["descricao"],
      dataCriado: DateTime.parse(json["dataCriado"]),
      pessoaCadastro: TipoDTO.fromJson(json["pessoaCadastro"]),
      tags: json["tags"] != null ? (json["tags"] as List).map((item) => TipoDTO.fromJson(item)).toList() : []
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "descricao": descricao,
    "dataCriado": dataCriado.toString(),
    "pessoaCadastro": pessoaCadastro.toJson(),
    "tags": tags.map((item) => item.toJson()).toList()
  };

  @override
  String toString() {
    return '$nome : $descricao';
  }

}