import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';
import 'package:projeto_forum_proeidi/enum/TipoDenuncia.enum.dart';

class DenunciaModel {
  final num id;
  final String descricao;
  final DateTime dataCriado;
  final TipoDTO<num> pessoaCadastro;
  final TipoDenuncia tipo;
  final num idTipo;

  DenunciaModel({
    this.id,
    this.descricao,
    this.dataCriado,
    this.pessoaCadastro,
    this.tipo,
    this.idTipo
  });

  factory DenunciaModel.fromJson(Map<String, dynamic> json) => DenunciaModel(
      id: json["id"],
      descricao: json["descricao"],
      dataCriado: json["dataCriado"],
      pessoaCadastro: TipoDTO.fromJson(json["pessoaCadastro"]),
      tipo: json["tipo"],
      idTipo: json["idTipo"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "descricao": descricao,
    "dataCriado": dataCriado,
    "pessoaCadastro": pessoaCadastro.toJson(),
    "tipo": tipo,
    "idTipo": idTipo
  };

  @override
  String toString() {
    return '$descricao';
  }
}