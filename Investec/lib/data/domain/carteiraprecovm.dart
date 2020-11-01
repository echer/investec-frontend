import 'package:json_annotation/json_annotation.dart';

import 'carteira.dart';

part 'carteiraprecovm.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class CarteiraPrecoVM {
  Carteira carteira;
  double variacao;
  double saldoAtual;
  double vlrInvestido;
  bool mostraCarteira;

  CarteiraPrecoVM({
    this.carteira,
    this.variacao,
    this.saldoAtual,
    this.vlrInvestido,
    this.mostraCarteira,
  });

  factory CarteiraPrecoVM.fromJson(Map<String, dynamic> json) =>
      _$CarteiraPrecoVMFromJson(json);
  Map<String, dynamic> toJson() => _$CarteiraPrecoVMToJson(this);
}
