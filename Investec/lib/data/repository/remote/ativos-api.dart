import 'dart:convert';

import 'package:Investec/App.dart';
import 'package:Investec/data/domain/carteira-ativo.dart';
import 'package:http/http.dart' as http;

class AtivosAPIImpl {
  String endpoint =
      "https://investec-backend.herokuapp.com/v1/carteira/:carteira/ativos";

  Future<List<AtivosCarteira>> list(String carteira) async {
    final response = await http.get(
      endpoint.replaceFirst(":carteira", carteira),
      headers: {
        "Authorization": "Bearer ${App.authorization}",
      },
    );

    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.body);
      final List<AtivosCarteira> list =
          json.map((resp) => AtivosCarteira.fromJson(resp)).toList();
      return list;
    } else {
      print("Error API");
      //throw Exception('Failed process request:');
      return [];
    }
  }
}
