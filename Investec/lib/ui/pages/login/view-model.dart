import 'package:Investec/data/domain/usuario.dart';
import 'package:Investec/data/repository/remote/dto/login.dart';
import 'package:Investec/data/repository/usuario-repository.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final UsuarioRepository repository;

  LoginViewModel(this.repository);

  Future<Login> login(Usuario obj) async {
    return await repository.login(obj);
  }

  Future<void> createOrUpdate(Usuario obj) {
    if (obj.id.isEmpty) {
      obj.id = null;
      return repository.create(obj);
    }
    return repository.update(obj);
  }

  Future<void> delete() {
    return repository.delete();
  }
}
