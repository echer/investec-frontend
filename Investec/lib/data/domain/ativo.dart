import 'package:Investec/data/domain/carteira.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ativo.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Ativo {
  String id;
  String ticker;
  Carteira carteira;
  double pmAtivo;
  double qtdAtivo;
  double stopGain;
  double stopLoss;
  double vlrInvestido;
  String createdOn;
  String modifiedOn;

  Ativo({
    this.id,
    this.ticker,
    this.carteira,
    this.pmAtivo,
    this.qtdAtivo,
    this.stopGain,
    this.stopLoss,
    this.vlrInvestido,
    this.createdOn,
    this.modifiedOn,
  });

  factory Ativo.fromJson(Map<String, dynamic> json) => _$AtivoFromJson(json);
  Map<String, dynamic> toJson() => _$AtivoToJson(this);
}
