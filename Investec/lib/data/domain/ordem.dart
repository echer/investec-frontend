import 'package:Investec/data/domain/ativo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ordem.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Ordem {
  String id;
  Ativo ativosCarteira;
  int tipoOrdem;
  String dtOrdem;
  int qtdOrdem;
  double vlrOrdem;
  double taxaOrdem;
  double totalOrdem;
  double totalOrdemLiquido;

  Ordem({
    this.id,
    this.ativosCarteira,
    this.tipoOrdem,
    this.dtOrdem,
    this.qtdOrdem,
    this.vlrOrdem,
    this.taxaOrdem,
    this.totalOrdem,
    this.totalOrdemLiquido,
  });

  factory Ordem.fromJson(Map<String, dynamic> json) => _$OrdemFromJson(json);
  Map<String, dynamic> toJson() => _$OrdemToJson(this);
}
