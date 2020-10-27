// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ordem _$OrdemFromJson(Map<String, dynamic> json) {
  return Ordem(
    id: json['id'] as String,
    ativosCarteira: json['ativosCarteira'] == null
        ? null
        : Ativo.fromJson(json['ativosCarteira'] as Map<String, dynamic>),
    tipoOrdem: json['tipoOrdem'] as int,
    qtdOrdem: json['qtdOrdem'] as int,
    vlrOrdem: (json['vlrOrdem'] as num)?.toDouble(),
    taxaOrdem: (json['taxaOrdem'] as num)?.toDouble(),
    totalOrdem: (json['totalOrdem'] as num)?.toDouble(),
    totalOrdemLiquido: (json['totalOrdemLiquido'] as num)?.toDouble(),
    createdOn: json['createdOn'] as String,
    modifiedOn: json['modifiedOn'] as String,
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
  writeNotNull('ativosCarteira', instance.ativosCarteira?.toJson());
  writeNotNull('tipoOrdem', instance.tipoOrdem);
  writeNotNull('qtdOrdem', instance.qtdOrdem);
  writeNotNull('vlrOrdem', instance.vlrOrdem);
  writeNotNull('taxaOrdem', instance.taxaOrdem);
  writeNotNull('totalOrdem', instance.totalOrdem);
  writeNotNull('totalOrdemLiquido', instance.totalOrdemLiquido);
  writeNotNull('createdOn', instance.createdOn);
  writeNotNull('modifiedOn', instance.modifiedOn);
  return val;
}
