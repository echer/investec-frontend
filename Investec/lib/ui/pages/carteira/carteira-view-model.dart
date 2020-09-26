import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/repository/carteira-repository.dart';
import 'package:flutter/material.dart';

class CarteiraViewModel extends ChangeNotifier {
  CarteiraRepository repository = new CarteiraRepository();

  List<Carteira> carteiras = List<Carteira>();

  Future<void> list() async {
    this.carteiras = await repository.list();
    notifyListeners();
  }
}
