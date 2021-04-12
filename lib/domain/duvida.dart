class Duvida {
  int id;
  String titulo;
  String texto;
  Duvida(this.id, this.titulo, this.texto);
  @override
  String toString() {
    return '$titulo : $texto';
  }
}
