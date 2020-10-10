import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/repository/carteira-repository.dart';
import 'package:flutter/material.dart';

class CarteiraViewModel extends ChangeNotifier {
  CarteiraViewModel(this.repository);

  final CarteiraRepository repository;

  List<Carteira> carteiras = List<Carteira>();

  Future<void> list() async {
    this.carteiras = await repository.list();
    notifyListeners();
  }

  Future<void> createOrUpdate(Carteira obj) {
    if (obj.id.isEmpty) {
      obj.id = null;
      return repository.create(obj);
    }
    return repository.update(obj);
  }

  Future<void> delete(Carteira obj) {
    return repository.delete(obj);
  }
}
