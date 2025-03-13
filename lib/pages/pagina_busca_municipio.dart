//import 'package:amp/models/modelo_municipio.dart';
import 'package:amp/models/modelo_municipio.dart';
import 'package:amp/providers/provider_lista_municipios.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaginaBuscaMunicipio extends StatefulWidget {
  const PaginaBuscaMunicipio({super.key});

  @override
  State<PaginaBuscaMunicipio> createState() => _PaginaBuscaMunicipioState();
}

class _PaginaBuscaMunicipioState extends State<PaginaBuscaMunicipio> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProviderListaMunicipios>(context, listen: false)
          .cargaMunicipios();
    });
  }

  chooseCity(ModeloMunicipio municipio) {
    //print(municipio.idEdo);
    //print(municipio.idMpo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buscar municipio"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 16,
            ),
            child: TextField(
              controller: _controller,
              onChanged: (texto) {
                Provider.of<ProviderListaMunicipios>(context, listen: false)
                    .filtraMunicipios(texto);
              },
              decoration: InputDecoration(
                prefix: Icon(Icons.search),
                labelText: "Filtrar municipios",
                //border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ProviderListaMunicipios>(
                builder: (context, proveedor, child) {
              if (proveedor.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                  itemCount: proveedor.listaDeMunicipios.length,
                  itemBuilder: (context, indice) {
                    final municipio = proveedor.listaDeMunicipios[indice];
                    return ListTile(
                      onTap: () => chooseCity(municipio),
                      title: Text(municipio.label),
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
