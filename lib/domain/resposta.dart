class Resposta {
  int id;
  String texto;
  bool melhorResposta;
  int quantidadeGostei;
  int quantidadeNaoGostei;
  Resposta(this.id, this.texto, this.melhorResposta, this.quantidadeGostei, this.quantidadeNaoGostei);
  @override
  String toString() {
    return '$texto';
  }
}
