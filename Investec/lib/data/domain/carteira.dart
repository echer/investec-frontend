import 'package:json_annotation/json_annotation.dart';

part 'carteira.g.dart';

@JsonSerializable(includeIfNull: false, explicitToJson: true)
class Carteira {
  String id;
  String nomeCarteira;
  double metaCarteira;
  String createdOn;
  String modifiedOn;

  Carteira({
    this.id,
    this.nomeCarteira,
    this.metaCarteira,
    this.createdOn,
    this.modifiedOn,
  });

  factory Carteira.fromJson(Map<String, dynamic> json) =>
      _$CarteiraFromJson(json);
  Map<String, dynamic> toJson() => _$CarteiraToJson(this);
}
