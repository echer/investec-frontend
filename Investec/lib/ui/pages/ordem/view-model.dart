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

  Future<void> createOrUpdate(Ordem obj) {
    if (obj.id.isEmpty) {
      obj.id = null;
      return repository.create(obj.carteiraId, obj.ativoId, obj);
    }
    return repository.update(obj.carteiraId, obj.ativoId, obj);
  }

  Future<void> delete(Ordem obj) {
    return repository.delete(obj.carteiraId, obj.ativoId, obj);
  }
}
