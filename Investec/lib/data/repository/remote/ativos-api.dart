import 'package:Investec/data/domain/ativo.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ativos-api.g.dart';

@RestApi(baseUrl: "https://investec-backend.herokuapp.com/v1/carteira")
abstract class AtivosAPI {
  factory AtivosAPI(Dio dio, {String baseUrl}) {
    return _AtivosAPI(dio, baseUrl: baseUrl);
  }

  @GET("/{carteira}/ativos")
  Future<List<Ativo>> list(@Path("carteira") String carteira);

  @POST("/{carteira}/ativos")
  Future create(@Path() String carteira, @Body() Ativo ativo);

  @PUT("/{carteira}/ativos/{id}")
  Future update(
      @Path() String carteira, @Path() String id, @Body() Ativo ativo);

  @DELETE("/{carteira}/ativos/{id}")
  Future delete(@Path() String carteira, @Path() String id);
}
