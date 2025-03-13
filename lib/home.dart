import 'package:amp/providers/provider_dias.dart';
import 'package:amp/providers/provider_lista_municipios.dart';
import 'package:amp/providers/provider_pronostico.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/pagina_inicial.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderListaMunicipios()),
        ChangeNotifierProvider(create: (context) => ProviderPronostico()),
        ChangeNotifierProvider(create: (context) => ProviderDias())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SMN",
        home: PaginaInicial(),
      ),
    );
  }
}
