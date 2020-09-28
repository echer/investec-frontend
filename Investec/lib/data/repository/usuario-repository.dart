import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/repository/remote/dto/login.dart';
import 'package:Investec/data/repository/remote/usuario-api.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:dio/dio.dart';

class UsuarioRepository {
  Future<Login> login(Usuario usuario) async {
    Dio dio = await serviceLocator<Dio>();
    UsuarioAPI api = UsuarioAPI(dio);
    return api.login(usuario);
  }
}
