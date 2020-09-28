import 'package:Investec/data/domain/carteira.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'carteira-api.g.dart';

@RestApi(baseUrl: "https://investec-backend.herokuapp.com/v1/")
abstract class CarteiraAPI {
  factory CarteiraAPI(Dio dio, {String baseUrl}) {
    return _CarteiraAPI(dio, baseUrl: baseUrl);
  }
  @GET("carteira")
  Future<List<Carteira>> list();
}
