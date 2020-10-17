import 'package:Investec/data/domain/ordem.dart';
import 'package:Investec/data/repository/ordens-repository.dart';
import 'package:flutter/material.dart';

class OrdemViewModel extends ChangeNotifier {
  final OrdensRepository repository;

  OrdemViewModel(this.repository);

  List<Ordem> ativos = List<Ordem>();

  Future<void> list(String carteira, String ativo) async {
    this.ativos = await repository.list(carteira, ativo);
    notifyListeners();
  }

  Future<void> create(String carteira, String ativo, Ordem obj) {
    obj.id = null;
    return repository.create(carteira, ativo, obj);
  }

  Future<void> delete(String carteira, String ativo, Ordem obj) {
    return repository.delete(carteira, ativo, obj);
  }

  void notify() {
    notifyListeners();
  }
}
