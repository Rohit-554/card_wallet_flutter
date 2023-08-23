import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:card_wallet/presentation/cubits/add_card_cubit/add_card_cubit.dart';
import 'package:card_wallet/presentation/cubits/add_card_cubit/add_card_state.dart';
import 'package:card_wallet/presentation/screen/credit_card/credit_cards_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';



class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture'),backgroundColor: Colors.black,),

      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {

            return CameraPreview(_controller);
          } else {

            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {

          try {

            await _initializeControllerFuture;


            final image = await _controller.takePicture();

            if (!mounted) return;


            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(
                  imagePath: image.path,
                ),
              ),
            );
          } catch (e) {

            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final addCardCubit = BlocProvider.of<AddCardCubit>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text('Display the Picture',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,

      ),
      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Image.file(File(imagePath)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                addCardCubit.addCard(
                  cardExpiration: "12/25",
                  cardHolder: "Test x",
                  cardNumber: "1234 5678 9012 3456",
                  category: "VISA",
                  name: "HDFC",
                );
                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Background color
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text("Add card"),
            ),
          ),
          const SizedBox(height: 20),
          BlocListener<AddCardCubit,AddCardCubitState>(
            listener: (context, state) {
              if (state is AddCardLoading) {

              }else if (state is AddCardSuccess){
                Fluttertoast.showToast(
                    msg: "Added successfully",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreditCardsPage(),
                  ),
                );
              }else if (state is AddCardException){

                Navigator.popUntil(context, ModalRoute.withName('/creditcards'));
              }
            },
            child: BlocBuilder<AddCardCubit,AddCardCubitState>(
              builder: (context, state) {
                if (state is AddCardLoading) {

                } else if (state is AddCardException) {

                } else if (state is AddCardSuccess) {
                  print("login hit");
                }

                return Container(); // Return a default widget for other cases
              },
            ),
          ),


        ],
      )


    );
  }
}