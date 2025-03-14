import 'package:flutter/material.dart';
import 'package:amp/models/modelo_dia.dart';
import 'package:amp/services/servicio_carga_dia.dart';

class ProviderDias with ChangeNotifier {
  List<ModeloDia> _dia = [];
  bool _estaCargando = false;

  List<ModeloDia> get dia => _dia;
  bool get estaCargando => _estaCargando;

  Future<void> cargaDia(int index) async {
    _estaCargando = true;
    notifyListeners();

    try {
      if (_dia.isEmpty) {
        //_dia = await ServicioCargaDia().descargaDia(index);
        List<ModeloDia> dias = await ServicioCargaDia().descargaDia(index);

        final horaActual = DateTime.now().hour;

        _dia = dias.where((dia) {
          final hora = int.tryParse(dia.time);
          return hora != null && hora >= horaActual && hora <= 23;
        }).toList();
      }
    } catch (e) {
      //print(e);
    } finally {
      _estaCargando = false;
      notifyListeners();
    }
  }
}
