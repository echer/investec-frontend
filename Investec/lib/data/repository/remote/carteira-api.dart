import 'dart:convert';
import 'package:Investec/App.dart';
import 'package:Investec/data/domain/carteira.dart';
import 'package:http/http.dart' as http;

class CarteiraAPIImpl {
  String endpoint = "https://investec-backend.herokuapp.com/v1/carteira";

  Future<List<Carteira>> list() async {
    final response = await http.get(
      endpoint,
      headers: {
        "Authorization": "Bearer ${App.authorization}",
      },
    );

    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.body);
      final List<Carteira> list =
          json.map((resp) => Carteira.fromJson(resp)).toList();
      return list;
    } else {
      print("Error API");
      //throw Exception('Failed process request:');
      return [];
    }
  }
}
