import 'package:card_wallet/presentation/screen/credit_card/singleCreditCardPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/display_card_data/Result.dart';
import 'input_form/credit_card_input_format_form.dart';

class CreditCardWidget extends StatelessWidget {
  final List<Result> creditCardResults; // List of Result objects
  final void Function(Result card)? onCardSelected;

  const CreditCardWidget(this.creditCardResults, {super.key, this.onCardSelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTitleSection(
                title: "Payment Details",
                subTitle: "How would you like to pay ?",
              ),
              SizedBox(height: 30), // Initial gap from the top
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: creditCardResults.length,
                itemBuilder: (context, index) {
                  final result = creditCardResults[index];
                  return Positioned(
                    top: 30 * (index + 1), // Gap between cards
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        _onCardTapped(result, context: context);
                      },
                      child: _buildCreditCard(
                        color: Colors.blueGrey,
                        cardExpiration: result.cardExpiration,
                        cardHolder: result.cardHolder,
                        cardNumber: result.cardNumber,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: _buildAddCardButton(
                icon: Icon(Icons.add),
                color: Color(0xFF081603),
                context: context,
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _onCardTapped(Result tappedCard, {required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SingleCreditCardPage(
          cardNumber: tappedCard.cardNumber,
          cardHolderName: tappedCard.cardHolder,
          bankName: tappedCard.name,
          expiryDate: tappedCard.cardExpiration,
        ),
      ),
    );
  }

  Column _buildTitleSection({@required title, @required subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Text(
            '$title',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            '$subTitle',
            style: const TextStyle(fontSize: 21, color: Colors.black45),
          ),
        )
      ],
    );
  }

  // Build the credit card widget
  Card _buildCreditCard(
      {required Color color,
        required String cardNumber,
        required String cardHolder,
        required String cardExpiration}) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: 200,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                cardNumber,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/contact_less.png",
          height: 20,
          width: 18,
        ),
        Image.asset(
          "assets/images/mastercard.png",
          height: 50,
          width: 50,
        ),
      ],
    );
  }

// Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              color: Colors.grey, fontSize: 9, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

// Build the FloatingActionButton
  Container _buildAddCardButton({
    required Icon icon,
    required Color color,
    required BuildContext context,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      alignment: Alignment.center,
      child: FloatingActionButton(
        elevation: 2.0,
        onPressed: () {
          //go to the add card page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNewCardScreen()),
          );
        },
        backgroundColor: color,
        mini: false,
        child: icon,
      ),
    );
  }

  void _onTap() {
    creditCardResults.forEach((element) {
      onCardSelected?.call(element);
    });
  }
}