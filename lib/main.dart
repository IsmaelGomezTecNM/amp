import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'home.dart';

void main() async {
  //hay que inicializar los widgets antes de correr al APP
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null);
  runApp(Home());
}
