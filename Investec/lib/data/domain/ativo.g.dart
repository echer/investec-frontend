// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ativo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ativo _$AtivoFromJson(Map<String, dynamic> json) {
  return Ativo(
    id: json['id'] as String,
    ticker: json['ticker'] as String,
    pmAtivo: (json['pmAtivo'] as num)?.toDouble(),
    qtdAtivo: (json['qtdAtivo'] as num)?.toDouble(),
    stopGain: (json['stopGain'] as num)?.toDouble(),
    stopLoss: (json['stopLoss'] as num)?.toDouble(),
    vlrInvestido: (json['vlrInvestido'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$AtivoToJson(Ativo instance) => <String, dynamic>{
      'id': instance.id,
      'ticker': instance.ticker,
      'pmAtivo': instance.pmAtivo,
      'qtdAtivo': instance.qtdAtivo,
      'stopGain': instance.stopGain,
      'stopLoss': instance.stopLoss,
      'vlrInvestido': instance.vlrInvestido,
    };
