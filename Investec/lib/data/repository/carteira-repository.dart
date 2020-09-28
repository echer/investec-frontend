import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/repository/remote/carteira-api.dart';

class CarteiraRepository {
  CarteiraAPI api = CarteiraAPI();

  Future<List<Carteira>> list() async {
    return api.list();
  }
}
