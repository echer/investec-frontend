import 'package:Investec/App.dart';
import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/repository/remote/dto/login.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'usuario-api.g.dart';

@RestApi(baseUrl: "https://investec-backend.herokuapp.com/v1/")
abstract class UsuarioAPI {
  factory UsuarioAPI({String baseUrl}) {
    Dio dio = Dio();
    dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (Options options) async {
      dio.interceptors.requestLock.lock();
      options.headers["Authorization"] = "Bearer ${App.authorization}";
      dio.interceptors.requestLock.unlock();
      return options;
    }));
    return _UsuarioAPI(dio, baseUrl: baseUrl);
  }

  @POST("usuario/login")
  Future<Login> list(@Body() Usuario usuario);
}
