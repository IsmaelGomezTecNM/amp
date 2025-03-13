class ModeloDia {
  ModeloDia({
    required this.nes,
    required this.nmun,
    required this.hloc,
    required this.nhor,
    required this.dsem,
    required this.temp,
    required this.desciel,
    required this.probprec,
    required this.prec,
    required this.velvien,
    required this.dirvienc,
    required this.dirvieng,
    required this.hr,
    required this.dpt,
    required this.time,
    required this.dh,
    required this.raf,
    required this.numdatos,
    required this.isExpanded,
  });

  String nes;
  String nmun;
  String hloc;
  String nhor;
  String dsem;
  String temp;
  String desciel;
  String probprec;
  String prec;
  String velvien;
  String dirvienc;
  String dirvieng;
  String hr;
  String dpt;
  String time;
  String dh;
  String raf;
  int numdatos;

  bool isExpanded = false;

  factory ModeloDia.fromJson(Map<String, dynamic> json) {
    return ModeloDia(
      nes: json["nes"] ?? "",
      nmun: json["nmun"] ?? "",
      hloc: json["hloc"] ?? "",
      nhor: json["nhor"] ?? "",
      dsem: json["dsem"] ?? "",
      temp: json["temp"] ?? "",
      desciel: json["desciel"] ?? "",
      probprec: json["probprec"] ?? "",
      prec: json["prec"] ?? "",
      velvien: json["velvien"] ?? "",
      dirvienc: json["dirvienc"] ?? "",
      dirvieng: json["dirvieng"] ?? "",
      hr: json["hr"] ?? "",
      dpt: json["dpt"] ?? "",
      time: json["time"] ?? "",
      dh: json["dh"] ?? "",
      raf: json["raf"] ?? "",
      numdatos: json["numdatos"] ?? 0,
      isExpanded: false,
    );
  }
}
