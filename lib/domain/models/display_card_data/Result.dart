class Result {
  Category category;
  String name;
  String cardExpiration;
  String cardHolder;
  String cardNumber;
  String id;

  Result({
    required this.category,
    required this.name,
    required this.cardExpiration,
    required this.cardHolder,
    required this.cardNumber,
    required this.id,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    Category category = categoryValues.map[json["category"]] ?? Category.VISA;
    return Result(
      category: category,
      name: json["name"],
      cardExpiration: json["cardExpiration"],
      cardHolder: json["cardHolder"],
      cardNumber: json["cardNumber"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "category": categoryValues.reverse[category],
    "name": name,
    "cardExpiration": cardExpiration,
    "cardHolder": cardHolder,
    "cardNumber": cardNumber,
    "id": id,
  };
}

enum Category {
  VISA
}

final categoryValues = EnumValues({
  "VISA": Category.VISA,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
