// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(
    usuario: json['usuario'] == null
        ? null
        : Usuario.fromJson(json['usuario'] as Map<String, dynamic>),
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$LoginToJson(Login instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('usuario', instance.usuario);
  writeNotNull('token', instance.token);
  return val;
}
