import 'dart:core';

import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';

class DuvidaModel extends TipoDTO<num> {
  String titulo;
  String descricao;
  DateTime dataCriado;
  DateTime dataUltimaEdicao;
  TipoDTO<num> pessoaCadastro;
  TipoDTO<num> pessoaUltimaEdicao;
  TipoDTO<num> topicoForum;
  TipoDTO<num> respostaCorreta;
  List<TipoDTO<dynamic>> tags;

  DuvidaModel(
      {id,
      nome,
      this.titulo,
      this.descricao,
      this.dataCriado,
      this.dataUltimaEdicao,
      this.pessoaCadastro,
      this.pessoaUltimaEdicao,
      this.topicoForum,
      this.respostaCorreta,
      this.tags})
      : super(id: id, nome: nome);

  factory DuvidaModel.fromJson(Map<String, dynamic> json) => DuvidaModel(
      id: json["id"],
      titulo: json["titulo"],
      descricao: json["descricao"],
      dataCriado: DateTime.parse(json["dataCriado"]),
      dataUltimaEdicao: DateTime.parse(json["dataUltimaEdicao"]),
      pessoaCadastro: TipoDTO.fromJson(json["pessoaCadastro"]),
      pessoaUltimaEdicao: TipoDTO.fromJson(json["pessoaUltimaEdicao"]),
      topicoForum: TipoDTO.fromJson(json["topicoForum"]),
      respostaCorreta: json["respostaCorreta"] != null
          ? TipoDTO.fromJson(json["respostaCorreta"])
          : null,
      tags: json["tags"] != null
          ? (json["tags"] as List)
              .map((item) => TipoDTO.fromJson(item))
              .toList()
          : []);

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descricao": descricao,
        "dataCriado": dataCriado != null ? dataCriado.toIso8601String() : "",
        "dataUltimaEdicao":
            dataUltimaEdicao != null ? dataUltimaEdicao.toIso8601String() : "",
        "pessoaCadastro": pessoaCadastro.toJson(),
        "pessoaUltimaEdicao":
            pessoaUltimaEdicao != null ? pessoaUltimaEdicao.toJson() : {},
        "topicoForum": topicoForum.toJson(),
        "respostaCorreta":
            respostaCorreta != null ? respostaCorreta.toJson() : null,
        "tags": tags.map((item) => item.toJson()).toList()
      };

  @override
  String toString() {
    return '$titulo : $descricao';
  }
}
