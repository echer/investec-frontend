import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/repository/remote/ativos-api.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:dio/dio.dart';

class AtivosRepository {
  Future<List<Ativo>> list(String carteira) async {
    Dio dio = getIt<Dio>();
    AtivosAPI api = AtivosAPI(dio);
    return api.list(carteira);
  }
}
