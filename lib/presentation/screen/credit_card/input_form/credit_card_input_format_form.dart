import 'package:card_wallet/presentation/screen/credit_card/camera/capture_card.dart';
import 'package:card_wallet/presentation/screen/credit_card/input_form/card_month_input_formatter.dart';
import 'package:card_wallet/presentation/screen/credit_card/input_form/card_number_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/card/CardType.dart';
import '../../../cubits/add_card_cubit/add_card_cubit.dart';
import '../../../cubits/add_card_cubit/add_card_state.dart';
import 'card_utils/card_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({Key? key}) : super(key: key);

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController cardNumberController = TextEditingController();

  CardType cardType = CardType.Invalid;

  @override
  void initState() {
    cardNumberController.addListener(
      () {
        getCardTypeFrmNumber();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addCardCubit = BlocProvider.of<AddCardCubit>(context);
    final nameController = TextEditingController();
    final cvvController = TextEditingController();
    final expiryController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("New card"), backgroundColor: Colors.black,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Spacer(),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                        CardNumberInputFormatter(),
                      ],
                      decoration: InputDecoration(hintText: "Card number",
                        suffix: CardUtils.getCardIcon(cardType),
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: TextFormField(
                        controller: nameController,
                        decoration:
                            const InputDecoration(hintText: "Full name"),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: cvvController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              // Limit the input
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: const InputDecoration(hintText: "CVV"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: expiryController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(5),
                              CardMonthInputFormatter(),
                            ],
                            decoration:
                                const InputDecoration(hintText: "MM/YY"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 2),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text("Add card",style: TextStyle(color: Colors.white)),
                      onPressed: () {
                      addCardCubit.addCard(
                        cardExpiration: expiryController.text,
                        cardHolder: nameController.text,
                        cardNumber: cardNumberController.text,
                        category: "VISA",
                        name: "HDFC x IDFC",
                      );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocListener<AddCardCubit,AddCardCubitState>(
                    listener: (context, state) {
                      if (state is AddCardLoading) {

                      }else if (state is AddCardSuccess){
                        print("login hitx");
                        Text("Added Successfully!!",style: TextStyle(color: Colors.green));
                        Fluttertoast.showToast(
                            msg: "Added successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }else if(state is AddCardException){
                        print("login hit");
                        Fluttertoast.showToast(
                            msg: "Added Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    },
                    child: BlocBuilder<AddCardCubit,AddCardCubitState>(
                      builder: (context, state) {
                        if (state is AddCardLoading) {

                        } else if (state is AddCardException) {

                        } else if (state is AddCardSuccess) {
                          print("login hitj");
                        }

                        return Container(); // Return a default widget for other cases
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text("Add card by camera",style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        final cameras = await availableCameras();
                        final firstCamera = cameras.first;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TakePictureScreen(
                              camera: firstCamera,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ]
              ),

              const Spacer(),

            ],
          ),
        ),
      ),
    );
  }

  void getCardTypeFrmNumber() {
    if (cardNumberController.text.length <= 6) {
      String input = CardUtils.getCleanedNumber(cardNumberController.text);
      CardType type = CardUtils.getCardTypeFrmNumber(input);
      if (type != cardType) {
        setState(() {
          cardType = type;
        });
      }
    }
  }

  @override
  void dispose() {
    cardNumberController.dispose();
    super.dispose();
  }

  Future<void> capture() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

  }

}
