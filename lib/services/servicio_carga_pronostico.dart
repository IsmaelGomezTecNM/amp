import 'dart:convert';

import 'package:amp/models/modelo_pronostico.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ServicioCargaPronostico {
  Future<List<ModeloPronostico>> descargaPronosticos() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/pronosticos.json');

      List<dynamic> pronosticos = jsonDecode(response);

      DateTime fechaActual = DateTime.now();
      var formateaFecha = DateFormat('d/MM');

      //return pronosticos.map((dia) => ModeloPronostico.fromJson(dia)).toList();

      return pronosticos
          .asMap()
          .map((index, dia) {
            String fechaFormateada;

            DateTime otroDia = fechaActual.add(Duration(days: index));
            fechaFormateada = formateaFecha.format(otroDia);

            dia['fecha'] = fechaFormateada;

            return MapEntry(index, ModeloPronostico.fromJson(dia));
          })
          .values
          .toList();
    } catch (e) {
      return [];
    }
  }
}
