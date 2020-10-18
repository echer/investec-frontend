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
    createdOn: json['createdOn'] as String,
    modifiedOn: json['modifiedOn'] as String,
  );
}

Map<String, dynamic> _$UsuarioToJson(Usuario instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('nome', instance.nome);
  writeNotNull('email', instance.email);
  writeNotNull('cpf', instance.cpf);
  writeNotNull('senha', instance.senha);
  writeNotNull('fone', instance.fone);
  writeNotNull('dtNascimento', instance.dtNascimento);
  writeNotNull('perfilInvestidor', instance.perfilInvestidor);
  writeNotNull('createdOn', instance.createdOn);
  writeNotNull('modifiedOn', instance.modifiedOn);
  return val;
}
