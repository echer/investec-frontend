import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/repository/remote/carteira-api.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:dio/dio.dart';

class CarteiraRepository {
  Future<List<Carteira>> list() async {
    Dio dio = getIt<Dio>();
    CarteiraAPI api = CarteiraAPI(dio);
    return api.list();
  }

  Future create(Carteira carteira) async {
    Dio dio = getIt<Dio>();
    CarteiraAPI api = CarteiraAPI(dio);
    return api.create(carteira);
  }

  Future update(Carteira carteira) async {
    Dio dio = getIt<Dio>();
    CarteiraAPI api = CarteiraAPI(dio);
    return api.update(carteira.id, carteira);
  }
}
