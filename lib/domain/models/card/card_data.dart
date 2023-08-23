import 'package:json_annotation/json_annotation.dart';

part 'card_data.g.dart'; // This file will be generated

@JsonSerializable()
class CardData {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'cardExpiration')
  final String cardExpiration;

  @JsonKey(name: 'cardHolder')
  final String cardHolder;

  @JsonKey(name: 'cardNumber')
  final String cardNumber;

  @JsonKey(name: 'category')
  final String category;

  CardData({
    required this.name,
    required this.cardExpiration,
    required this.cardHolder,
    required this.cardNumber,
    required this.category,
  });

  factory CardData.fromJson(Map<String, dynamic> json) => _$CardDataFromJson(json);
  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}
