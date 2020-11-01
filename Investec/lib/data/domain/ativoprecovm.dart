import 'package:Investec/data/domain/ativo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ativoprecovm.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class AtivoPrecoVM {
  Ativo ativo;
  double precoAtual;
  double variacao;
  double saldoAtual;

  AtivoPrecoVM({
    this.ativo,
    this.precoAtual,
    this.variacao,
    this.saldoAtual,
  });

  factory AtivoPrecoVM.fromJson(Map<String, dynamic> json) =>
      _$AtivoPrecoVMFromJson(json);
  Map<String, dynamic> toJson() => _$AtivoPrecoVMToJson(this);
}
