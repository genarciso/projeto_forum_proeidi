class TipoDTO<ID> {
  final ID id;
  final String nome;

  TipoDTO({this.id, this.nome});

  factory TipoDTO.fromJson(Map<String, dynamic> json) => TipoDTO(
    id: json["id"],
    nome: json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
  };
}