import 'package:Investec/data/domain/carteira.dart';
import 'package:Investec/data/repository/remote/carteira-api.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:dio/dio.dart';

class CarteiraRepository {
  Future<List<Carteira>> list() async {
    Dio dio = await serviceLocator<Dio>();
    CarteiraAPI api = CarteiraAPI(dio);
    return api.list();
  }
}
