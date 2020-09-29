import 'package:Investec/data/domain/usuario.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable(includeIfNull: false)
class Login {
  Usuario usuario;
  String token;

  Login({this.usuario, this.token});

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
