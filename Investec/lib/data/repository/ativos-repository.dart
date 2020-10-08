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

  Future create(String carteira, Ativo ativo) async {
    Dio dio = getIt<Dio>();
    AtivosAPI api = AtivosAPI(dio);
    return api.create(carteira, ativo);
  }

  Future update(String carteira, Ativo ativo) async {
    Dio dio = getIt<Dio>();
    AtivosAPI api = AtivosAPI(dio);
    return api.update(carteira, ativo.id, ativo);
  }

  Future delete(String carteira, Ativo ativo) async {
    Dio dio = getIt<Dio>();
    AtivosAPI api = AtivosAPI(dio);
    return api.delete(carteira, ativo.id);
  }
}
