// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carteira.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Carteira _$CarteiraFromJson(Map<String, dynamic> json) {
  return Carteira(
    id: json['id'] as String,
    nomeCarteira: json['nomeCarteira'] as String,
    metaCarteira: (json['metaCarteira'] as num)?.toDouble(),
    createdOn: json['createdOn'] as String,
    modifiedOn: json['modifiedOn'] as String,
  );
}

Map<String, dynamic> _$CarteiraToJson(Carteira instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('nomeCarteira', instance.nomeCarteira);
  writeNotNull('metaCarteira', instance.metaCarteira);
  writeNotNull('createdOn', instance.createdOn);
  writeNotNull('modifiedOn', instance.modifiedOn);
  return val;
}
