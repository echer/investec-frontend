import 'package:Investec/data/domain/carteira-ativo.dart';
import 'package:Investec/data/repository/remote/ativos-api.dart';

class AtivosRepository {
  AtivosAPIImpl api = new AtivosAPIImpl();

  Future<List<AtivosCarteira>> list(String carteira) async {
    return api.list(carteira);
  }
}
