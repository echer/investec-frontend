import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/repository/remote/dto/login.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'usuario-api.g.dart';

@RestApi(baseUrl: "https://investec-backend.herokuapp.com/v1/")
abstract class UsuarioAPI {
  factory UsuarioAPI(Dio dio, {String baseUrl}) {
    return _UsuarioAPI(dio, baseUrl: baseUrl);
  }
  @POST("usuario/login")
  Future<Login> login(@Body() Usuario usuario);
}
