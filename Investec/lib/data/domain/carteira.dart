import 'package:Investec/data/repository/remote/json-utils.dart';

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

  factory Carteira.fromJson(Map<String, dynamic> json) {
    return Carteira(
        id: json['id'],
        nomeCarteira: json['nomeCarteira'],
        dtCriacao: json['dtCriacao'],
        metaCarteira: JsonUtils.parseDouble(json['metaCarteira']),
        saldoCarteira: JsonUtils.parseDouble(json['saldoCarteira']),
        varCarteira: JsonUtils.parseDouble(json['varCarteira']));
  }
}
