// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ativo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ativo _$AtivoFromJson(Map<String, dynamic> json) {
  return Ativo(
    id: json['id'] as String,
    ticker: json['ticker'] as String,
    carteira: json['carteira'] == null
        ? null
        : Carteira.fromJson(json['carteira'] as Map<String, dynamic>),
    pmAtivo: (json['pmAtivo'] as num)?.toDouble(),
    qtdAtivo: (json['qtdAtivo'] as num)?.toDouble(),
    stopGain: (json['stopGain'] as num)?.toDouble(),
    stopLoss: (json['stopLoss'] as num)?.toDouble(),
    vlrInvestido: (json['vlrInvestido'] as num)?.toDouble(),
    createdOn: json['createdOn'] as String,
    modifiedOn: json['modifiedOn'] as String,
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
  writeNotNull('carteira', instance.carteira?.toJson());
  writeNotNull('pmAtivo', instance.pmAtivo);
  writeNotNull('qtdAtivo', instance.qtdAtivo);
  writeNotNull('stopGain', instance.stopGain);
  writeNotNull('stopLoss', instance.stopLoss);
  writeNotNull('vlrInvestido', instance.vlrInvestido);
  writeNotNull('createdOn', instance.createdOn);
  writeNotNull('modifiedOn', instance.modifiedOn);
  return val;
}
