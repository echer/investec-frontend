import 'package:json_annotation/json_annotation.dart';

import 'carteira.dart';

part 'carteiraprecovm.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CarteiraPrecoVM {
  Carteira carteira;
  double variacao;
  double saldoAtual;
  double vlrInvestido;

  CarteiraPrecoVM({this.carteira});

  factory CarteiraPrecoVM.fromJson(Map<String, dynamic> json) =>
      _$CarteiraPrecoVMFromJson(json);
  Map<String, dynamic> toJson() => _$CarteiraPrecoVMToJson(this);
}
