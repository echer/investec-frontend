import 'package:Investec/App.dart';
import 'package:Investec/data/domain/ativo.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ativos-api.g.dart';

@RestApi(baseUrl: "https://investec-backend.herokuapp.com/v1/")
abstract class AtivosAPI {
  factory AtivosAPI({String baseUrl}) {
    Dio dio = Dio();
    dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      dio.interceptors.requestLock.lock();
      options.headers["Authorization"] = "Bearer ${App.authorization}";
      dio.interceptors.requestLock.unlock();
      return options;
    }));
    return _AtivosAPI(dio, baseUrl: baseUrl);
  }

  @GET("carteira/:carteira/ativos")
  Future<List<Ativo>> list(@Path("carteira") String carteira);
}
