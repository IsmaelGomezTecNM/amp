import 'package:amp/custom_widgets/texto_gris_negrita.dart';
import 'package:amp/models/modelo_pronostico.dart';
import 'package:flutter/material.dart';

class DiaPrincipal extends StatelessWidget {
  final ModeloPronostico dia;

  Widget separador = Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      border: Border(
        right: BorderSide(
          color: Colors.black,
          width: 2,
        ),
      ),
    ),
    child: SizedBox(
      width: 40.0,
      height: 40.0,
    ),
  );

  DiaPrincipal({super.key, required this.dia});

  Widget Elemento(String texto, IconData icono, String medida) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(texto),
        Row(
          children: [
            Icon(icono),
            Text(medida),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(dia.desciel),
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_outlined,
                size: 80,
                color: Colors.amber,
              ),
              Text(
                dia.tmax,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 80,
                ),
              ),
              Text(
                '/${dia.tmin} °C',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
        MediaQuery.of(context).size.width <= 600
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    TextoGrisNegrita(
                        texto: "Precipitación: ",
                        medida: "${dia.prec} litros/m²"),
                    TextoGrisNegrita(
                        texto: "Probabilidad de lluvia: ",
                        medida: "${dia.probprec} %"),
                    TextoGrisNegrita(
                        texto: "Velocidad del viento: ",
                        medida: "${dia.velvien} km/h"),
                    TextoGrisNegrita(
                        texto: "Dirección del viento: ", medida: dia.dirvienc),
                    TextoGrisNegrita(
                        texto: "Ráfaga de viento: ",
                        medida: "${dia.velvien} km/h"),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Elemento("Lluvia", Icons.snooze, "${dia.prec} litros/m²"),
                  separador,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Probabilidad de lluvia'),
                      Row(
                        children: [
                          Icon(Icons.cloudy_snowing),
                          Text("${dia.prec} litros/m²"),
                        ],
                      )
                    ],
                  ),
                  separador,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dirección del viento'),
                      Row(
                        children: [
                          Icon(Icons.cloudy_snowing),
                          Text("${dia.prec} litros/m²"),
                        ],
                      )
                    ],
                  ),
                  separador,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Velocidad del viento'),
                      Row(
                        children: [
                          Icon(Icons.cloudy_snowing),
                          Text("${dia.prec} litros/m²"),
                        ],
                      )
                    ],
                  )
                ],
              )
      ],
    );
  }
}
