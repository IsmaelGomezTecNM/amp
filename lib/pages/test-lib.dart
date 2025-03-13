import 'package:amp/custom_widgets/dia_principal.dart';
import 'package:amp/custom_widgets/texto_gris_negrita.dart';
import 'package:amp/custom_widgets/widget_dia.dart';
import 'package:amp/models/modelo_dia.dart';
import 'package:amp/models/modelo_municipio.dart';
import 'package:amp/models/modelo_pronostico.dart';
import 'package:amp/pages/pagina_busca_municipio.dart';
import 'package:amp/providers/provider_dias.dart';
import 'package:amp/providers/provider_lista_municipios.dart';
import 'package:amp/providers/provider_pronostico.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaginaInicial extends StatefulWidget {
  const PaginaInicial({super.key});

  @override
  State<PaginaInicial> createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  String _statusMessage = '';
  bool _isGPSEnabled = false;
  String _cityName = "";
  String hoy = DateFormat('dd MMMM', 'es_ES').format(DateTime.now());
  int _diaSeleccionado = 0;

  @override
  void initState() {
    super.initState();

    _getLocation();

    Future.microtask(() {
      Provider.of<ProviderPronostico>(context, listen: false)
          .cargaPronosticos();
      Provider.of<ProviderDias>(context, listen: false)
          .cargaDia(_diaSeleccionado);
    });
  }

  Future<void> _getLocation() async {
    _isGPSEnabled = await Geolocator.isLocationServiceEnabled();

    if (!_isGPSEnabled) {
      setState(() {
        _statusMessage = "El servicio de ubicación está desactivado";
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        setState(() {
          _statusMessage = "Permiso negado";
        });
      } else if (permission == LocationPermission.deniedForever) {
        setState(() {
          _statusMessage = 'Permiso negado permanentemente';
        });
      } else {
        _cargaCiudad();
      }
    } else {
      _cargaCiudad();
    }
  }

  Future<void> _cargaCiudad() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      ModeloMunicipio municipio = await ProviderListaMunicipios()
          .obtenerMunicipioPorNombre(placemarks.first.locality.toString());
      setState(() {
        _cityName = municipio.label;
      });
    }
  }

  void _alSeleccionarDia(int index) {
    if (_diaSeleccionado != index) {
      setState(() {
        _diaSeleccionado = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sistema meteorológico"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaginaBuscaMunicipio(),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Buscar municipio",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            _cityName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
          ),
          SizedBox(height: 4),
          Text(
            hoy,
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 8),
          Consumer<ProviderPronostico>(builder: (context, provider, child) {
            if (provider.estaCargando) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (provider.pronosticos.isEmpty) {
              return Center(
                child: Text("No hay pronósticos disponibles"),
              );
            }
            ModeloPronostico diaPrincipal = provider.pronosticos[0];

            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DiaPrincipal(dia: diaPrincipal),

                    // 🔹 Cuatro widgets medianos (100% ancho)
                    Column(
                      children: List.generate(
                        4,
                        (index) => Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          height: 80,
                          width: double.infinity,
                          color: Colors.green[200],
                          alignment: Alignment.center,
                          child: Text("Widget Mediano ${index + 1}"),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),

                    // 🔹 Row con ChoiceChips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          4,
                          (index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: ChoiceChip(
                              label: Text("Chip ${index + 1}"),
                              selected: false,
                              onSelected: (selected) {},
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),

                    // 🔹 23 Widgets medianos
                    Column(
                      children: List.generate(
                        23,
                        (index) => Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          height: 100,
                          width: double.infinity,
                          color: Colors.orange[200],
                          alignment: Alignment.center,
                          child: Text("Elemento ${index + 1}"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}



          /*
          Consumer<ProviderPronostico>(
            builder: (context, provider, child) {
              if (provider.estaCargando) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (provider.pronosticos.isEmpty) {
                return Center(
                  child: Text("No hay pronósticos disponibles"),
                );
              }

              ModeloPronostico diaPrincipal = provider.pronosticos[0];

              return SingleChildScrollView(
                child: Column(
                  children: [
                    DiaPrincipal(dia: diaPrincipal),
                    Column(
                      children: List.generate(
                        provider.pronosticos.length,
                        (index) {
                          ModeloPronostico pronostico =
                              provider.pronosticos[index];
                          return WidgetDia();
                        },
                      ),
                    ),
                    provider.estaCargando
                        ? CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(provider.pronosticos.length,
                                (index) {
                              ModeloPronostico pronostico =
                                  provider.pronosticos[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ChoiceChip(
                                  showCheckmark: false,
                                  labelStyle: TextStyle(
                                      color: _diaSeleccionado == index
                                          ? Colors.white
                                          : Colors.black),
                                  label: Text(pronostico.fecha ?? '$index'),
                                  selected: _diaSeleccionado == index,
                                  selectedColor: Colors.green,
                                  onSelected: (selected) {
                                    if (!provider.estaCargando) {
                                      _alSeleccionarDia(index);
                                    }
                                  },
                                ),
                              );
                            }),
                          ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Consumer<ProviderDias>(
              builder: (context, providerDia, child) {
                if (providerDia.estaCargando) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (providerDia.dia.isEmpty) {
                  return Center(
                    child: Text("No hay pronósticos disponibles"),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      providerDia.dia.length,
                      (index) {
                        ModeloDia pronostico = providerDia.dia[index];
                        return ListTile(
                          title: Text(pronostico.temp),
                          subtitle: Text(pronostico.dh),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        */