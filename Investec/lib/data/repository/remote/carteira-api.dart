import 'package:Investec/data/domain/carteira.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'carteira-api.g.dart';

@RestApi(baseUrl: "https://investec-backend.herokuapp.com/v1/carteira")
abstract class CarteiraAPI {
  factory CarteiraAPI(Dio dio, {String baseUrl}) {
    return _CarteiraAPI(dio, baseUrl: baseUrl);
  }
  @GET("/")
  Future<List<Carteira>> list();

  @POST("/")
  Future create(@Body() Carteira carteira);

  @PUT("/{id}")
  Future update(@Path() String id, @Body() Carteira carteira);

  @DELETE("/{id}")
  Future delete(@Path() String id);
}
