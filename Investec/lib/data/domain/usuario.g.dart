// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) {
  return Usuario(
    id: json['id'] as String,
    nome: json['nome'] as String,
    email: json['email'] as String,
    cpf: json['cpf'] as String,
    senha: json['senha'] as String,
    fone: json['fone'] as String,
    dtNascimento: json['dtNascimento'] as String,
    perfilInvestidor: json['perfilInvestidor'] as int,
  );
}

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'email': instance.email,
      'cpf': instance.cpf,
      'senha': instance.senha,
      'fone': instance.fone,
      'dtNascimento': instance.dtNascimento,
      'perfilInvestidor': instance.perfilInvestidor,
    };
