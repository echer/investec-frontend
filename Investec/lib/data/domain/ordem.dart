import 'package:Investec/data/domain/ativoprecovm.dart';
import 'package:json_annotation/json_annotation.dart';

import 'ativo.dart';

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
  String createdOn;
  String modifiedOn;

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
    this.createdOn,
    this.modifiedOn,
  });

  factory Ordem.fromJson(Map<String, dynamic> json) => _$OrdemFromJson(json);
  Map<String, dynamic> toJson() => _$OrdemToJson(this);
}
