import 'package:amp/models/modelo_pronostico.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './texto_gris_negrita.dart';
import 'package:weather_icons/weather_icons.dart';

class WidgetDia extends StatelessWidget {
  final ModeloPronostico pronostico;
  final int index;

  final Map<String, IconData> iconosClima = {
    'Despejado': WeatherIcons.day_sunny,
    'Poco nuboso': WeatherIcons.day_cloudy,
    'Cielo nublado': WeatherIcons.cloud,
    'Medio nublado': WeatherIcons.day_cloudy,
    // Agrega más descripciones e íconos según sea necesario
  };

  WidgetDia({super.key, required this.pronostico, required this.index});

  @override
  Widget build(BuildContext context) {
    String fechaFormateada = pronostico.fecha ?? '';

    IconData? icono = iconosClima[pronostico.desciel];

    // Si no se encuentra el ícono, muestra un ícono por defecto
    if (icono == null) {
      icono = WeatherIcons.day_sunny;
    }

    DateFormat formatoEntrada = DateFormat('d/MM');
    DateTime fechaParseada = formatoEntrada.parse(fechaFormateada);

    if (index == 0) {
      fechaFormateada = "Hoy";
    } else if (index == 1) {
      fechaFormateada = "Mañana";
    } else {
      DateFormat formatoSalida = DateFormat('EEEE', 'es_ES');
      fechaFormateada = formatoSalida.format(fechaParseada);
    }

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: LayoutBuilder(builder: (context, condicionantes) {
          double ancho = condicionantes.maxWidth;
          bool esTelefono = MediaQuery.of(context).size.width <= 600;

          double tamano = esTelefono ? (ancho / 2) - 10 : ancho;

          return Container(
            padding: EdgeInsets.all(2.0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fechaFormateada),
                Text(
                  pronostico.fecha ?? '',
                  style: TextStyle(color: Colors.black54),
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10.0,
                  runSpacing: 10.0,
                  children: [
                    SizedBox(
                      width: tamano,
                      child: Icon(
                        icono,
                        size: 80,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(
                      width: tamano,
                      child: Column(
                        children: [
                          Text(
                            pronostico.desciel,
                            style:
                                TextStyle(fontSize: 18, color: Colors.black54),
                          ),
                          Row(
                            children: [
                              Text(
                                pronostico.tmax,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 40,
                                ),
                              ),
                              Text(
                                '/${pronostico.tmin} °C',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: tamano,
                      child: TextoGrisNegrita(
                          texto: 'Lluvia: ',
                          medida: pronostico.prec + ' litros/m²'),
                    ),
                    SizedBox(
                      width: tamano,
                      child: TextoGrisNegrita(
                          texto: 'Prob de lluvia ',
                          medida: "${pronostico.probprec} km/h"),
                    ),
                    SizedBox(
                      width: tamano,
                      child: TextoGrisNegrita(
                          texto: 'Vel del viento ',
                          medida: "${pronostico.velvien} km/h"),
                    ),
                    SizedBox(
                      width: tamano,
                      child: TextoGrisNegrita(
                          texto: 'Dir del viento ',
                          medida: "${pronostico.dirvienc}"),
                    ),
                    SizedBox(
                      width: tamano,
                      child: TextoGrisNegrita(
                          texto: 'Lluvia ',
                          medida: pronostico.prec + ' litros/m²'),
                    ),
                    SizedBox(
                      width: tamano,
                      child: TextoGrisNegrita(
                          texto: 'Ráf de viento ',
                          medida: "${pronostico.raf} km/h"),
                    ),
                  ],
                )
              ],
            ),
          );
        }));
  }
}
