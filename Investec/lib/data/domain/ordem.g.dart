// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ordem _$OrdemFromJson(Map<String, dynamic> json) {
  return Ordem(
    id: json['id'] as String,
    ativoId: json['ativoId'] as String,
    carteiraId: json['carteiraId'] as String,
    tipoOrdem: json['tipoOrdem'] as int,
    dtOrdem: json['dtOrdem'] as String,
    qtdOrdem: json['qtdOrdem'] as int,
    vlrOrdem: (json['vlrOrdem'] as num)?.toDouble(),
    taxaOrdem: (json['taxaOrdem'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$OrdemToJson(Ordem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('ativoId', instance.ativoId);
  writeNotNull('carteiraId', instance.carteiraId);
  writeNotNull('tipoOrdem', instance.tipoOrdem);
  writeNotNull('dtOrdem', instance.dtOrdem);
  writeNotNull('qtdOrdem', instance.qtdOrdem);
  writeNotNull('vlrOrdem', instance.vlrOrdem);
  writeNotNull('taxaOrdem', instance.taxaOrdem);
  return val;
}
