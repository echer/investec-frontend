import 'dart:convert';
import 'package:Investec/data/domain/carteira.dart';
import 'package:http/http.dart' as http;

class CarteiraAPIImpl {
  String endpoint = "https://investec-backend.herokuapp.com/v1/carteira";

  Future<List<Carteira>> list() async {
    final response = await http.get(
      endpoint,
      headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjM5YTEyMDBhLTViZjQtNGY4Ni1hZTY5LWQ2YjIyZWRjYjI3ZiIsIm5iZiI6MTYwMTEzNzExNCwiZXhwIjoxNjAxMTU1MTE0LCJpYXQiOjE2MDExMzcxMTR9.tHpIhgmyoi-ByIRo1s2gowyJLlUp2PS411zvkPUkwdg",
      },
    );

    if (response.statusCode == 200) {
      final Iterable json = jsonDecode(response.body);
      final List<Carteira> carteiras =
          json.map((movie) => Carteira.fromJson(movie)).toList();
      return carteiras;
    } else {
      print("Error API");
      throw Exception('Failed process request:');
    }
  }
}
