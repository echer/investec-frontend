import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/repository/remote/carteira-api.dart';

class CarteiraRepository {
  CarteiraAPIImpl api = new CarteiraAPIImpl();

  Future<List<Carteira>> list() async {
    return api.list();
  }
}
