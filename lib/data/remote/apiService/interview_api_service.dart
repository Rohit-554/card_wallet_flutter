

import 'package:card_wallet/domain/models/display_card_data/CardData.dart';
import 'package:card_wallet/domain/models/display_card_data/Result.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../utils/constants/strings.dart';
import '../../../domain/models/card/card_data.dart';

part 'interview_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.JsonSerializable)
abstract class InterviewApiService {
  factory InterviewApiService(Dio dio, {String baseUrl}) = _InterviewApiService;



  @POST('auth/register')
  Future<HttpResponse<void>> registerUser(@Body() RegistrationRequest request);

  @POST('auth/login')
  Future<HttpResponse<void>> loginUser(@Body() LoginRequest request);

  @POST('cards')
  Future<HttpResponse<void>> addCard(@Body() CardData request);

  @GET('cards')
  Future<HttpResponse<CardDataDisp>> getCards();

  @GET('cards/{id}')
  Future<HttpResponse<Result>> getCard(@Path('id') String id);
}

@JsonSerializable()
class RegistrationRequest {
  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "password")
  final String password;

  RegistrationRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$RegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationRequestToJson(this);
}
@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
