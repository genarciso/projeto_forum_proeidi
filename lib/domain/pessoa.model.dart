import 'package:projeto_forum_proeidi/domain/tipoDTO.dart';

class PessoaModel extends TipoDTO<num> {
  String usuario;
  String email;
  String senha;
  DateTime dataNascimento;

  PessoaModel({id, nome, this.usuario, this.email, this.senha, this.dataNascimento}) : super(id: id, nome: nome);

  factory PessoaModel.fromJson(Map<String, dynamic> json) => PessoaModel(
    id: json["id"],
    nome: json["nome"],
    usuario: json["usuario"],
    email: json["email"],
    senha: json["senha"],
    dataNascimento: DateTime.parse(json["dataNascimento"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "usuario": usuario,
    "email": email,
    "senha": senha,
    "dataNascimento": dataNascimento.toIso8601String()
  };

  @override
  String toString() {
    return '$id, $usuario, $nome, $senha';
  }
}