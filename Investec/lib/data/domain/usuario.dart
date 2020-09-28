import 'package:json_annotation/json_annotation.dart';

part 'usuario.g.dart';

@JsonSerializable()
class Usuario {
  String id;
  String nome;
  String email;
  String cpf;
  String senha;
  String fone;
  String dtNascimento;
  int perfilInvestidor;

  Usuario(
      {this.id,
      this.nome,
      this.email,
      this.cpf,
      this.senha,
      this.fone,
      this.dtNascimento,
      this.perfilInvestidor});

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}
