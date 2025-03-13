import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:amp/models/modelo_municipio.dart';
//import 'package:http/http.dart' as http;

class ServicioCargaMunicipios {
  Future<List<ModeloMunicipio>> descargaMunicipios() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/datos_municipios.json');

      List<dynamic> listaDeMunicipios = jsonDecode(response);

      return listaDeMunicipios
          .map((municipio) => ModeloMunicipio.fromJson(municipio))
          .toList();

      /*
      final response = await http.get(Uri.parse(
          'https://smn.conagua.gob.mx/tools/PHP/pronostico_municipios_grafico/controlador/getDataJson2String.php?edo=9&mun=16'));
      if (response.statusCode == 200) {
        List<dynamic> listaDeMunicipios = jsonDecode(response.body);
        print(response.body);
        return listaDeMunicipios
            .map((municipio) => ModeloMunicipio.fromJson(municipio))
            .toList();
      }
      return [];
      */
    } catch (e) {
      print(e);
      return [];
    }
  }
}
