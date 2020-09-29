// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carteira.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Carteira _$CarteiraFromJson(Map<String, dynamic> json) {
  return Carteira(
    id: json['id'] as String,
    nomeCarteira: json['nomeCarteira'] as String,
    dtCriacao: json['dtCriacao'] as String,
    metaCarteira: (json['metaCarteira'] as num)?.toDouble(),
    saldoCarteira: (json['saldoCarteira'] as num)?.toDouble(),
    varCarteira: (json['varCarteira'] as num)?.toDouble(),
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
  writeNotNull('dtCriacao', instance.dtCriacao);
  writeNotNull('metaCarteira', instance.metaCarteira);
  writeNotNull('saldoCarteira', instance.saldoCarteira);
  writeNotNull('varCarteira', instance.varCarteira);
  return val;
}
