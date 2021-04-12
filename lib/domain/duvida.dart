import 'package:projeto_forum_proeidi/domain/resposta.dart';

class Duvida {
  int id;
  String titulo;
  String texto;
  List<Resposta> respostas;
  Duvida(this.id, this.titulo, this.texto, this.respostas);
  @override
  String toString() {
    return '$titulo : $texto';
  }
}
