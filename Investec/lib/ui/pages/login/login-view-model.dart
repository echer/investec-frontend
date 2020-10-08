import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/repository/remote/dto/login.dart';
import 'package:Investec/data/repository/usuario-repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  UsuarioRepository repository = new UsuarioRepository();

  Future<Login> login(Usuario usuario) async {
    return await repository.login(usuario);
  }

  Future<void> createOrUpdate(Usuario usuario) {
    if (usuario.id.isEmpty) {
      usuario.id = null;
      return repository.create(usuario);
    }
    return repository.update(usuario);
  }

  Future<void> delete() {
    return repository.delete();
  }
}
