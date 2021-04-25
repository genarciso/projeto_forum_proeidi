import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';

class DenunciaModel {
  final num id;
  final String descricao;
  final DateTime dataCriado;
  final TipoDTO<num> pessoaCadastro;
  final String tipoDenuncia;
  final num idTipo;

  DenunciaModel({
    this.id,
    this.descricao,
    this.dataCriado,
    this.pessoaCadastro,
    this.tipoDenuncia,
    this.idTipo
  });

  factory DenunciaModel.fromJson(Map<String, dynamic> json) => DenunciaModel(
      id: json["id"],
      descricao: json["descricao"],
      dataCriado: DateTime.parse(json["dataCriado"]),
      pessoaCadastro: TipoDTO.fromJson(json["pessoaCadastro"]),
      tipoDenuncia: json["tipoDenuncia"],
      idTipo: json["idTipo"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "descricao": descricao,
    "dataCriado": dataCriado != null ? dataCriado.toIso8601String() : "",
    "pessoaCadastro": pessoaCadastro.toJson(),
    "tipoDenuncia": tipoDenuncia,
    "idTipo": idTipo
  };

  @override
  String toString() {
    return '$descricao';
  }
}