import 'package:Investec/data/domain/ativo.dart';
import 'package:Investec/data/repository/remote/ativos-api.dart';

class AtivosRepository {
  AtivosAPI api = AtivosAPI();
  Future<List<Ativo>> list(String carteira) async {
    return api.list(carteira);
  }
}
