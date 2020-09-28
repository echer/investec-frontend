import 'package:Investec/data/domain/ativo.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ativos-api.g.dart';

@RestApi(baseUrl: "https://investec-backend.herokuapp.com/v1/")
abstract class AtivosAPI {
  factory AtivosAPI(Dio dio, {String baseUrl}) {
    return _AtivosAPI(dio, baseUrl: baseUrl);
  }

  @GET("carteira/:carteira/ativos")
  Future<List<Ativo>> list(@Path("carteira") String carteira);
}
