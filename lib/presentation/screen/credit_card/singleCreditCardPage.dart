import 'package:flutter/material.dart';



class SingleCreditCardPage extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String bankName;

  const SingleCreditCardPage({super.key,
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.bankName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Card Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardDetailRow('Card Number', cardNumber),
            // _buildCardDetailRow('CVV', cvv),
            _buildCardDetailRow('Expiry Date', expiryDate),
            _buildCardDetailRow('Card Holder Name', cardHolderName),
            _buildCardDetailRow('Bank Name', bankName),
          ],
        ),
      ),
    );
  }

  Widget _buildCardDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
