import 'package:json_annotation/json_annotation.dart';

part 'ordem.g.dart';

@JsonSerializable(includeIfNull: false)
class Ordem {
  String id;
  String ativoId;
  String carteiraId;
  int tipoOrdem;
  String dtOrdem;
  int qtdOrdem;
  double vlrOrdem;
  double taxaOrdem;

  Ordem(
      {this.id,
      this.ativoId,
      this.carteiraId,
      this.tipoOrdem,
      this.dtOrdem,
      this.qtdOrdem,
      this.vlrOrdem,
      this.taxaOrdem});

  factory Ordem.fromJson(Map<String, dynamic> json) => _$OrdemFromJson(json);
  Map<String, dynamic> toJson() => _$OrdemToJson(this);
}
