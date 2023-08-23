// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardData _$CardDataFromJson(Map<String, dynamic> json) => CardData(
      name: json['name'] as String,
      cardExpiration: json['cardExpiration'] as String,
      cardHolder: json['cardHolder'] as String,
      cardNumber: json['cardNumber'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      'name': instance.name,
      'cardExpiration': instance.cardExpiration,
      'cardHolder': instance.cardHolder,
      'cardNumber': instance.cardNumber,
      'category': instance.category,
    };
