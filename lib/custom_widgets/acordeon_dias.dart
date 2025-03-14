import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amp/providers/provider_dias.dart';
import 'package:amp/models/modelo_dia.dart';

// ignore: must_be_immutable
class AcordeonDias extends StatelessWidget {
  String fecha = "";
  AcordeonDias({super.key, this.fecha = ""});

  @override
  Widget build(BuildContext context) {
    final providerDias = Provider.of<ProviderDias>(context);
    final dias = providerDias.dia;

    if (providerDias.estaCargando) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: ExpansionPanelList.radio(
        initialOpenPanelValue: 0,
        children: dias.asMap().entries.map((elemento) {
          int index = elemento.key;
          ModeloDia dia = elemento.value;

          return ExpansionPanelRadio(
            value: index,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                leading: SizedBox(
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(
                        //color: Color(0xFFE0E0E0),
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${dia.time}:00h",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              fecha,
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.sunny,
                          size: 40,
                          color: Colors.amber,
                        ),
                        Text(
                          "${dia.temp}°C",
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          dia.desciel,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            body: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Temperatura: ${dia.temp}°C"),
                  Text("Cielo: ${dia.desciel}"),
                  Text("Probabilidad de lluvia: ${dia.probprec}%"),
                  Text("Precipitación: ${dia.prec} mm"),
                  Text("Viento: ${dia.velvien} km/h (${dia.dirvienc})"),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
