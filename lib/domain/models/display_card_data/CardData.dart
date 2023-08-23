import 'dart:convert';

import 'Result.dart';

CardDataDisp cardDataFromJson(String str) => CardDataDisp.fromJson(json.decode(str));

String cardDataToJson(CardDataDisp data) => json.encode(data.toJson());

class CardDataDisp {
  List<Result> results;
  int page;
  int limit;
  int totalPages;
  int totalResults;

  CardDataDisp({
    required this.results,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  factory CardDataDisp.fromJson(Map<String, dynamic> json) => CardDataDisp(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
    totalResults: json["totalResults"],
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
    "totalResults": totalResults,
  };
}