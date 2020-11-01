// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carteiraprecovm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarteiraPrecoVM _$CarteiraPrecoVMFromJson(Map<String, dynamic> json) {
  return CarteiraPrecoVM(
    carteira: json['carteira'] == null
        ? null
        : Carteira.fromJson(json['carteira'] as Map<String, dynamic>),
    variacao: (json['variacao'] as num)?.toDouble(),
    saldoAtual: (json['saldoAtual'] as num)?.toDouble(),
    vlrInvestido: (json['vlrInvestido'] as num)?.toDouble(),
    mostraCarteira: json['mostraCarteira'] as bool,
  );
}

Map<String, dynamic> _$CarteiraPrecoVMToJson(CarteiraPrecoVM instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('carteira', instance.carteira?.toJson());
  writeNotNull('variacao', instance.variacao);
  writeNotNull('saldoAtual', instance.saldoAtual);
  writeNotNull('vlrInvestido', instance.vlrInvestido);
  writeNotNull('mostraCarteira', instance.mostraCarteira);
  return val;
}
