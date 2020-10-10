import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/repository/ativos-repository.dart';
import 'package:flutter/material.dart';

class AtivosViewModel extends ChangeNotifier {
  final AtivosRepository repository;

  AtivosViewModel(this.repository);

  List<Ativo> ativos = List<Ativo>();

  Future<void> list(String carteira) async {
    this.ativos = await repository.list(carteira);
    notifyListeners();
  }

  Future<void> createOrUpdate(Ativo ativo) {
    if (ativo.id.isEmpty) {
      ativo.id = null;
      return repository.create(ativo.carteiraId, ativo);
    }
    return repository.update(ativo.carteiraId, ativo);
  }

  Future<void> delete(Ativo ativo) {
    return repository.delete(ativo.carteiraId, ativo);
  }
}
