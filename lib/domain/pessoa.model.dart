import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';

class PessoaModel extends TipoDTO<num> {
  final String usuario;
  final String email;
  DateTime dataNascimento;

  PessoaModel({id, nome, this.usuario, this.email, this.dataNascimento}) : super(id: id, nome: nome);

  factory PessoaModel.fromJson(Map<String, dynamic> json) => PessoaModel(
    id: json["id"],
    nome: json["nome"],
    usuario: json["usuario"],
    email: json["email"],
    dataNascimento: json["dataNascimento"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "usuario": usuario,
    "email": email,
    "dataNascimento": dataNascimento
  };

  @override
  String toString() {
    return '$usuario: $nome';
  }
}