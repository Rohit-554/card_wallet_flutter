import 'package:card_wallet/presentation/screen/credit_card/credit_cards_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../cubits/register_cubit_state.dart';
import '../../../../../cubits/register_user_cubit.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends HookWidget {
  const SignUpForm({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerUserCubit = BlocProvider.of<RegisterUserCubit>(context);
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
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
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              CircularProgressIndicator;
              registerUserCubit.registerUser(
                name: "test",
                email: emailTextController.text,
                password: passwordTextController.text,
              );
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          BlocListener<RegisterUserCubit, RegisterCubitState>(
            listener: (context, state) {
              if (state is RegisterException) {
                emailTextController.clear();
                passwordTextController.clear();
              }else if (state is RegisterSuccess){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CreditCardsPage();
                    },
                  ),
                );
              }
            },
            child: BlocBuilder<RegisterUserCubit, RegisterCubitState>(
              builder: (context, state) {
                if (state is RegisterLoading) {

                } else if (state is RegisterException) {
                  return
                    Text(
                    state.errorMessage,
                    style: TextStyle(color: Colors.red),
                  );
                } else if (state is RegisterSuccess) {
                  print("register hit1");
                }

                return Container(); // Return a default widget for other cases
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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
