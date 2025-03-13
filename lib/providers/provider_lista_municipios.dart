import 'package:amp/models/modelo_municipio.dart';
import 'package:amp/services/servicio_carga_municipios.dart';
import 'package:flutter/material.dart';

class ProviderListaMunicipios with ChangeNotifier {
  List<ModeloMunicipio> _lista_de_municipios = [];
  List<ModeloMunicipio> _lista_de_municipios_filtrada = [];
  bool _isLoading = false;

  List<ModeloMunicipio> get listaDeMunicipios => _lista_de_municipios_filtrada;
  bool get isLoading => _isLoading;

  Future<void> cargaMunicipios() async {
    _isLoading = true;
    notifyListeners();

    try {
      if (listaDeMunicipios.isEmpty) {
        _lista_de_municipios =
            await ServicioCargaMunicipios().descargaMunicipios();
      }
      _lista_de_municipios_filtrada = List.from(_lista_de_municipios);
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filtraMunicipios(String texto) {
    if (texto.isEmpty) {
      _lista_de_municipios_filtrada = List.from(_lista_de_municipios);
    } else {
      _lista_de_municipios_filtrada = _lista_de_municipios
          .where((municipio) =>
              municipio.label.toLowerCase().contains(texto.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  Future<ModeloMunicipio> obtenerMunicipioPorNombre(
      String nombreMunicipio) async {
    if (_lista_de_municipios.isEmpty) {
      await cargaMunicipios();
    }

    final municipio = _lista_de_municipios.firstWhere(
        (elemento) => elemento.label
            .toLowerCase()
            .contains(nombreMunicipio.toLowerCase()),
        orElse: () =>
            ModeloMunicipio(label: "", idEdo: "idEdo", idMpo: "idMpo"));

    return municipio;
  }
}
