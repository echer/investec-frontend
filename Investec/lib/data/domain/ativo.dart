import 'package:json_annotation/json_annotation.dart';

part 'ativo.g.dart';

@JsonSerializable(includeIfNull: false)
class Ativo {
  String id;
  String ticker;
  String carteiraId;
  double pmAtivo;
  double qtdAtivo;
  double stopGain;
  double stopLoss;
  double vlrInvestido;

  Ativo(
      {this.id,
      this.ticker,
      this.carteiraId,
      this.pmAtivo,
      this.qtdAtivo,
      this.stopGain,
      this.stopLoss,
      this.vlrInvestido});

  factory Ativo.fromJson(Map<String, dynamic> json) => _$AtivoFromJson(json);
  Map<String, dynamic> toJson() => _$AtivoToJson(this);
}
