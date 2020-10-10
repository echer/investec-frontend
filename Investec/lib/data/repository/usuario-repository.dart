import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/repository/remote/dto/login.dart';
import 'package:Investec/data/repository/remote/usuario-api.dart';

abstract class UsuarioRepository {
  factory UsuarioRepository(UsuarioAPI api) {
    return _UsuarioRepository(api);
  }

  Future<Login> login(Usuario obj);

  Future create(Usuario obj);

  Future update(Usuario obj);

  Future delete();
}

class _UsuarioRepository implements UsuarioRepository {
  final UsuarioAPI api;

  _UsuarioRepository(this.api);

  Future<Login> login(Usuario obj) async {
    return api.login(obj);
  }

  Future create(Usuario obj) async {
    return api.create(obj);
  }

  Future update(Usuario obj) async {
    return api.update(obj);
  }

  Future delete() async {
    return api.delete();
  }
}
