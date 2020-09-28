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

Map<String, dynamic> _$CarteiraToJson(Carteira instance) => <String, dynamic>{
      'id': instance.id,
      'nomeCarteira': instance.nomeCarteira,
      'dtCriacao': instance.dtCriacao,
      'metaCarteira': instance.metaCarteira,
      'saldoCarteira': instance.saldoCarteira,
      'varCarteira': instance.varCarteira,
    };
