
import 'package:card_wallet/data/remote/apiService/interview_api_service.dart';
import 'package:card_wallet/domain/repository/create_card_repository.dart';
import 'package:card_wallet/domain/repository/display_card.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';

import 'data/remote/apiService/dioInterceptor/dioInterceptor.dart';
import 'data/repository/create_card_repository_impl.dart';
import 'data/repository/display_card_repository_impl.dart';
import 'data/repository/register_repo_impl.dart';
import 'data/repository/login_repository_impl.dart';
import 'domain/repository/register_repository.dart';
import 'domain/repository/login_user.dart';
final locator = GetIt.instance;

Future<void> setupLocator() async{
  final dio = createDioInstance();
  dio.interceptors.add(AwesomeDioInterceptor());

  locator.registerSingleton<Dio>(dio);
  locator.registerSingleton<InterviewApiService>(
    InterviewApiService(locator.get<Dio>()),
  );
  locator.registerSingleton<RegisterRepository>(
    RegisterRepositoryImpl(locator.get<InterviewApiService>()),
  );
  locator.registerSingleton<LoginUserRepository>(
    LoginRepositoryImpl(locator.get<InterviewApiService>()),
  );
  locator.registerSingleton<CreateCardRepository>(
    CreateCardRepositoryImpl(locator.get<InterviewApiService>()),
  );
  locator.registerSingleton<DisplayCardRepository>(
    DisplayCardRepositoryImpl(locator.get<InterviewApiService>()),
  );
}