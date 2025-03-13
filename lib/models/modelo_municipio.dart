class ModeloMunicipio {
  String label;
  String idEdo;
  String idMpo;

  ModeloMunicipio({
    required this.label,
    required this.idEdo,
    required this.idMpo,
  });

  factory ModeloMunicipio.fromJson(Map<String, dynamic> json) {
    return ModeloMunicipio(
      label: json['label'] ?? "Ciudad Valles, San Luis Potosí",
      idEdo: json['id_edo'] ?? "24",
      idMpo: json['id_mpo'] ?? "13",
    );
  }
}
