import 'package:card_wallet/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:card_wallet/presentation/cubits/login_cubit/login_cubit_state.dart';
import 'package:card_wallet/presentation/cubits/register_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../credit_card/credit_cards_page.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends HookWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    late SharedPreferences prefs;
    final loginUserCubit = BlocProvider.of<LoginCubit>(context);
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();

    useEffect(() => () async {
      prefs = await SharedPreferences.getInstance();
    }, const []);
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailTextController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordTextController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                print("emailis ${emailTextController.text}");
                print("passwordis ${passwordTextController.text}");
                loginUserCubit.loginUser(
                  email: emailTextController.text,
                  password: passwordTextController.text,
                );
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          BlocListener<LoginCubit, LoginCubitState>(
            listener: (context, state) {
              if (state is LoginException) {
                emailTextController.clear();
                passwordTextController.clear();
              }else if (state is LoginSuccess){
                print("login hit1");
                // prefs.setString('email', emailTextController.text);
                // prefs.setString('password', passwordTextController.text);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CreditCardsPage();
                    },
                  ),
                );
              }
            },
            child: BlocBuilder<LoginCubit, LoginCubitState>(
              builder: (context, state) {
                if (state is LoginLoading) {

                } else if (state is LoginException) {
                  return
                    Text(
                      state.errorMessage,
                      style: TextStyle(color: Colors.red),
                    );
                } else if (state is LoginSuccess) {
                    print("login hit");
                }

                return Container(); // Return a default widget for other cases
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
