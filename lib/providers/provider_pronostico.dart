import 'package:flutter/material.dart';
import 'package:amp/models/modelo_pronostico.dart';
import 'package:amp/services/servicio_carga_pronostico.dart';

class ProviderPronostico with ChangeNotifier {
  List<ModeloPronostico> _pronosticos = [];
  bool _esta_cargando = false;

  List<ModeloPronostico> get pronosticos => _pronosticos;
  bool get estaCargando => _esta_cargando;

  Future<void> cargaPronosticos() async {
    _esta_cargando = true;
    notifyListeners();

    try {
      if (_pronosticos.isEmpty) {
        _pronosticos = await ServicioCargaPronostico().descargaPronosticos();
        //print(_pronosticos);
      }
    } catch (e) {
      print(e);
    } finally {
      _esta_cargando = false;
      notifyListeners();
    }
  }
}
