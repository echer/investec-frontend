import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/domain/ativoprecovm.dart';
import 'package:Investec/data/repository/remote/ativos-api.dart';

abstract class AtivosRepository {
  factory AtivosRepository(AtivosAPI api) {
    return _AtivosRepository(api);
  }

  Future<List<AtivoPrecoVM>> list(String carteira);

  Future create(String carteira, Ativo obj);

  Future update(String carteira, Ativo obj);

  Future delete(String carteira, Ativo obj);
}

class _AtivosRepository implements AtivosRepository {
  final AtivosAPI api;

  _AtivosRepository(this.api);

  Future<List<AtivoPrecoVM>> list(String carteira) async {
    return api.list(carteira);
  }

  Future create(String carteira, Ativo obj) async {
    return api.create(carteira, obj);
  }

  Future update(String carteira, Ativo obj) async {
    return api.update(carteira, obj.id, obj);
  }

  Future delete(String carteira, Ativo obj) async {
    return api.delete(carteira, obj.id);
  }
}
