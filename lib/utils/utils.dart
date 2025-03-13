class Utils {
  static String redondeaString(String valor) {
    return double.parse(valor).round().toString();
  }

  static bool esNumero(String valor) {
    return double.tryParse(valor) != null;
  }

  static Map<String, dynamic> redondeaNumeros(Map<String, dynamic> json) {
    json.forEach((llave, valor) {
      if (valor is String && esNumero(valor)) {
        json[llave] = redondeaString(valor);
      }
    });
    return json;
  }
}
