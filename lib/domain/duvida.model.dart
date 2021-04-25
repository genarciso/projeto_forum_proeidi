import 'dart:core';

import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';

class DuvidaModel extends TipoDTO<num> {
  final String titulo;
  final String descricao;
  final DateTime dataCriado;
  final DateTime dataUltimaEdicao;
  final TipoDTO<num> pessoaCadastro;
  final TipoDTO<num> pessoaUltimaEdicao;
  final TipoDTO<num> topicoForum;
  TipoDTO<num> respostaCorreta;
  List<TipoDTO<dynamic>> tags;

  DuvidaModel({
    id,
    nome,
    this.titulo,
    this.descricao,
    this.dataCriado,
    this.dataUltimaEdicao,
    this.pessoaCadastro,
    this.pessoaUltimaEdicao,
    this.topicoForum,
    this.respostaCorreta,
    this.tags
  }) : super(id: id, nome: nome);

  factory DuvidaModel.fromJson(Map<String, dynamic> json) => DuvidaModel(
    id: json["id"],
    nome: json["nome"],
    titulo: json["titulo"],
    descricao: json["descricao"],
    dataCriado: DateTime.parse(json["dataCriado"]),
    dataUltimaEdicao: DateTime.parse(json["dataUltimaEdicao"]),
    pessoaCadastro: TipoDTO.fromJson(json["pessoaCadastro"]),
    pessoaUltimaEdicao: TipoDTO.fromJson(json["pessoaUltimaEdicao"]),
    topicoForum: TipoDTO.fromJson(json["topicoForum"]),
    respostaCorreta: json["respostaCorreta"] != null ? TipoDTO.fromJson(json["respostaCorreta"]) : null,
    tags: json["tags"] != null ? (json["tags"] as List).map((item) => TipoDTO.fromJson(item)).toList() : []
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "titulo": titulo,
    "descricao": descricao,
    "dataCriado": dataCriado.toString(),
    "dataUltimaEdicao": dataUltimaEdicao.toString(),
    "pessoaCadastro": pessoaCadastro.toJson(),
    "pessoaUltimaEdicao": pessoaUltimaEdicao.toJson(),
    "topicoForum": topicoForum.toJson(),
    "respostaCorreta": respostaCorreta.toJson(),
    "tags": tags.map((item) => item.toJson()).toList()
  };

  @override
  String toString() {
    return '$titulo : $descricao';
  }
}
