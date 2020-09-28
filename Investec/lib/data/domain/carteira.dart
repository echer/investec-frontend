import 'package:json_annotation/json_annotation.dart';

part 'carteira.g.dart';

@JsonSerializable()
class Carteira {
  String id;
  String nomeCarteira;
  String dtCriacao;
  double metaCarteira;
  double saldoCarteira;
  double varCarteira;

  Carteira(
      {this.id,
      this.nomeCarteira,
      this.dtCriacao,
      this.metaCarteira,
      this.saldoCarteira,
      this.varCarteira});

  factory Carteira.fromJson(Map<String, dynamic> json) =>
      _$CarteiraFromJson(json);
  Map<String, dynamic> toJson() => _$CarteiraToJson(this);
}
