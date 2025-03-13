import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:amp/models/modelo_dia.dart';

class ServicioCargaDia {
  Future<List<ModeloDia>> descargaDia(int index) async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/dia${index + 1}.json');

      List<dynamic> listaDedia = jsonDecode(response);

      return listaDedia.map((dia) => ModeloDia.fromJson(dia)).toList();
    } catch (e) {
      //print(e);
      return [];
    }
  }
}
