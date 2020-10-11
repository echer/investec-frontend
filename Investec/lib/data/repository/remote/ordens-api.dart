import 'package:Investec/data/domain/ordem.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ordens-api.g.dart';

@RestApi(baseUrl: "https://investec-backend.herokuapp.com/v1/carteira")
abstract class OrdensAPI {
  factory OrdensAPI(Dio dio, {String baseUrl}) {
    return _OrdensAPI(dio, baseUrl: baseUrl);
  }

  @GET("/{carteira}/ativos/{ativo}/ordens")
  Future<List<Ordem>> list(@Path() String carteira, @Path() String ativo);

  @POST("/{carteira}/ativos/{ativo}/ordens")
  Future create(
      @Path() String carteira, @Path() String ativo, @Body() Ordem obj);

  @DELETE("/{carteira}/ativos/{ativo}/ordens/{id}")
  Future delete(
      @Path() String carteira, @Path() String ativo, @Path() String id);
}
