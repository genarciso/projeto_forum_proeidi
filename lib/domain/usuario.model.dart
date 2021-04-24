import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';
import 'package:projeto_forum_proeidi/enum/TipoPapel.enum.dart';

class UsuarioModel extends TipoDTO<num> {
  final String usuario;
  final String email;
  DateTime dataNascimento;
  final TipoPapel papel;

  UsuarioModel({id, nome, this.usuario, this.email, this.dataNascimento, this.papel}) : super(id: id, nome: nome);

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
      id: json["id"],
      nome: json["nome"],
      usuario: json["usuario"],
      email: json["email"],
      dataNascimento: json["dataNascimento"],
      papel: json["papel"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "usuario": usuario,
    "email": email,
    "dataNascimento": dataNascimento,
    "papel": papel
  };

  @override
  String toString() {
    return '$usuario: $nome';
  }
}