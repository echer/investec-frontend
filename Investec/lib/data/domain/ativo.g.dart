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

Map<String, dynamic> _$AtivoToJson(Ativo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('ticker', instance.ticker);
  writeNotNull('pmAtivo', instance.pmAtivo);
  writeNotNull('qtdAtivo', instance.qtdAtivo);
  writeNotNull('stopGain', instance.stopGain);
  writeNotNull('stopLoss', instance.stopLoss);
  writeNotNull('vlrInvestido', instance.vlrInvestido);
  return val;
}
