import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/domain/carteiraprecovm.dart';
import 'package:Investec/data/repository/remote/carteira-api.dart';

abstract class CarteiraRepository {
  factory CarteiraRepository(CarteiraAPI api) {
    return _CarteiraRepository(api);
  }

  Future<List<CarteiraPrecoVM>> list();

  Future create(Carteira obj);

  Future update(Carteira obj);

  Future delete(Carteira obj);
}

class _CarteiraRepository implements CarteiraRepository {
  final CarteiraAPI api;

  _CarteiraRepository(this.api);

  Future<List<CarteiraPrecoVM>> list() async {
    return api.list();
  }

  Future create(Carteira obj) async {
    return api.create(obj);
  }

  Future update(Carteira obj) async {
    return api.update(obj.id, obj);
  }

  Future delete(Carteira obj) async {
    return api.delete(obj.id);
  }
}
