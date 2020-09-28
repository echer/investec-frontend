import 'package:Investec/App.dart';
import 'package:Investec/data/domain/carteira.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'carteira-api.g.dart';

@RestApi(baseUrl: "https://investec-backend.herokuapp.com/v1/")
abstract class CarteiraAPI {
  factory CarteiraAPI({String baseUrl}) {
    Dio dio = Dio();
    dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      dio.interceptors.requestLock.lock();
      options.headers["Authorization"] = "Bearer ${App.authorization}";
      dio.interceptors.requestLock.unlock();
      return options;
    }));
    return _CarteiraAPI(dio, baseUrl: baseUrl);
  }

  @GET("carteira")
  Future<List<Carteira>> list();
}
