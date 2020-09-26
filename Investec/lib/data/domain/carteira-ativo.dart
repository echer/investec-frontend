import 'package:Investec/data/repository/remote/json-utils.dart';

class AtivosCarteira {
  String id;
  String ticker;
  double pmAtivo;
  double qtdAtivo;
  double stopGain;
  double stopLoss;
  double vlrInvestido;

  AtivosCarteira(
      {this.id,
      this.ticker,
      this.pmAtivo,
      this.qtdAtivo,
      this.stopGain,
      this.stopLoss,
      this.vlrInvestido});

  factory AtivosCarteira.fromJson(Map<String, dynamic> json) {
    return AtivosCarteira(
      id: json['id'],
      ticker: json['ticker'],
      pmAtivo: JsonUtils.parseDouble(json['pmAtivo']),
      qtdAtivo: JsonUtils.parseDouble(json['qtdAtivo']),
      stopGain: JsonUtils.parseDouble(json['stopGain']),
      stopLoss: JsonUtils.parseDouble(json['stopLoss']),
      vlrInvestido: JsonUtils.parseDouble(json['vlrInvestido']),
    );
  }
}
