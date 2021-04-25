import 'package:projeto_forum_proeidi/domain/usuario.model.dart';

class AutenticacaoModel {
  final UsuarioModel usuarioModel;
  final String papel;

  String errorMessage;
  String token;

  AutenticacaoModel({this.usuarioModel, this.papel, this.errorMessage, this.token});

  factory AutenticacaoModel.fromJson(Map<String, dynamic> json) => AutenticacaoModel(
      errorMessage: json["errorMessage"],
      token: json["token"],
      usuarioModel: UsuarioModel.fromJson(json["dataNascimento"]),
      papel: json["papel"]
  );

  Map<String, dynamic> toJson() => {
    "errorMessage": errorMessage,
    "token": token,
    "usuarioModel": usuarioModel.toJson(),
    "papel": papel
  };

  @override
  String toString() {
    return "${usuarioModel.nome}: $token";
  }
}