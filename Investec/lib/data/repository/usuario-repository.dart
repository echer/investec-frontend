import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/repository/remote/dto/login.dart';
import 'package:Investec/data/repository/remote/usuario-api.dart';
import 'package:Investec/data/service/service-locator.dart';
import 'package:dio/dio.dart';

class UsuarioRepository {
  Future<Login> login(Usuario usuario) async {
    Dio dio = getIt<Dio>();
    UsuarioAPI api = UsuarioAPI(dio);
    return api.login(usuario);
  }

  Future create(Usuario usuario) async {
    Dio dio = getIt<Dio>();
    UsuarioAPI api = UsuarioAPI(dio);
    return api.create(usuario);
  }

  Future update(Usuario usuario) async {
    Dio dio = getIt<Dio>();
    UsuarioAPI api = UsuarioAPI(dio);
    return api.update(usuario);
  }

  Future delete() async {
    Dio dio = getIt<Dio>();
    UsuarioAPI api = UsuarioAPI(dio);
    return api.delete();
  }
}
