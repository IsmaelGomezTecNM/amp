import 'package:amp/utils/utils.dart';

class ModeloPronostico {
  String nes;
  String nmun;
  String tmax;
  String tmin;
  String desciel;
  String probprec;
  String prec;
  String velvien;
  String dirvienc;
  String raf;

  String? fecha;

  ModeloPronostico({
    required this.nes,
    required this.nmun,
    required this.tmax,
    required this.tmin,
    required this.desciel,
    required this.probprec,
    required this.prec,
    required this.velvien,
    required this.dirvienc,
    required this.raf,
    this.fecha,
  });

  factory ModeloPronostico.fromJson(Map<String, dynamic> jsonStr) {
    Map<String, dynamic> json = Utils.redondeaNumeros(jsonStr);
    return ModeloPronostico(
        fecha: json['fecha'] ?? '',
        nes: json['nes'] ?? '',
        nmun: json['nmun'] ?? '',
        tmax: json['tmax'] ?? '',
        tmin: json['tmin'] ?? '',
        desciel: json['desciel'] ?? '',
        probprec: json['probprec'] ?? '',
        prec: json['prec'] ?? '',
        velvien: json['velvien'] ?? '',
        dirvienc: json['dirvienc'] ?? '',
        raf: json['raf'] ?? '');
  }
}
