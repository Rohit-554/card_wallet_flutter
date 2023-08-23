
import 'package:card_wallet/domain/repository/register_repository.dart';
import 'package:card_wallet/domain/repository/login_user.dart';
import 'package:card_wallet/locator.dart';
import 'package:card_wallet/presentation/cubits/add_card_cubit/add_card_cubit.dart';
import 'package:card_wallet/presentation/cubits/display_cards/displayCardsCubit.dart';
import 'package:card_wallet/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:card_wallet/presentation/cubits/register_user_cubit.dart';
import 'package:card_wallet/presentation/screen/credit_card/credit_cards_page.dart';

import 'package:card_wallet/presentation/screen/login/constants.dart';
import 'package:card_wallet/presentation/screen/onboarding/onboarding.dart';
import 'package:card_wallet/presentation/screen/onboarding/pages/Create%20A%20Card/create_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/repository/create_card_repository.dart';
import 'domain/repository/display_card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) =>
               RegisterUserCubit(locator<RegisterRepository>())
          ),
          BlocProvider(create: (context) =>
              LoginCubit(locator<LoginUserRepository>())
          ),
          BlocProvider(create: (context) =>
               AddCardCubit(locator<CreateCardRepository>())
          ),
          BlocProvider(create: (context) =>
              DisplayCardsCubit(locator<DisplayCardRepository>())..getCards()
          ),

        ],
        child: MaterialApp(
          title: 'Flutter Auth',
          theme: ThemeData(
              primaryColor: kPrimaryColor,
              scaffoldBackgroundColor: Colors.white,
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: kPrimaryColor,
                  shape: const StadiumBorder(),
                  maximumSize: const Size(double.infinity, 56),
                  minimumSize: const Size(double.infinity, 56),
                ),
              ),
              inputDecorationTheme: const InputDecorationTheme(
                filled: true,
                fillColor: kPrimaryLightColor,
                iconColor: kPrimaryColor,
                prefixIconColor: kPrimaryColor,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
              )),
          home: FutureBuilder<bool>(
            // Check if email is stored in shared preferences
            future: checkEmailInSharedPreferences(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Show loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // Navigate based on shared preference value
                final screenHeight = MediaQuery.of(context).size.height;
                return snapshot.data == true ? const CreditCardsPage() : Onboarding(screenHeight:screenHeight);
              }
            },
          ),
        ));
  }
  Future<bool> checkEmailInSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    return email != null && email.isNotEmpty;
  }
}

