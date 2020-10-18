// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ativoprecovm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AtivoPrecoVM _$AtivoPrecoVMFromJson(Map<String, dynamic> json) {
  return AtivoPrecoVM(
    ativo: json['ativo'] == null
        ? null
        : Ativo.fromJson(json['ativo'] as Map<String, dynamic>),
  )
    ..precoAtual = (json['precoAtual'] as num)?.toDouble()
    ..variacao = (json['variacao'] as num)?.toDouble()
    ..saldoAtual = (json['saldoAtual'] as num)?.toDouble();
}

Map<String, dynamic> _$AtivoPrecoVMToJson(AtivoPrecoVM instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ativo', instance.ativo?.toJson());
  writeNotNull('precoAtual', instance.precoAtual);
  writeNotNull('variacao', instance.variacao);
  writeNotNull('saldoAtual', instance.saldoAtual);
  return val;
}
