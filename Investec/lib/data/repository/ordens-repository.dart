import 'package:Investec/data/domain/ordem.dart';
import 'package:Investec/data/repository/remote/ordens-api.dart';

abstract class OrdensRepository {
  factory OrdensRepository(OrdensAPI api) {
    return _OrdensRepository(api);
  }

  Future<List<Ordem>> list(String carteira, String ativo);

  Future create(String carteira, String ativo, Ordem obj);

  Future delete(String carteira, String ativo, Ordem obj);
}

class _OrdensRepository implements OrdensRepository {
  final OrdensAPI api;

  _OrdensRepository(this.api);

  Future<List<Ordem>> list(String carteira, String ativo) async {
    return api.list(carteira, ativo);
  }

  Future create(String carteira, String ativo, Ordem obj) async {
    return api.create(carteira, ativo, obj);
  }

  Future delete(String carteira, String ativo, Ordem obj) async {
    return api.delete(carteira, ativo, obj.id);
  }
}
