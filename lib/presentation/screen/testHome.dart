import 'package:flutter/material.dart';

class StackedCardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Directionality(
        textDirection: TextDirection.ltr, // or TextDirection.rtl if needed
        child: Scaffold(
          appBar: AppBar(
            title: Text('Card Stacking'),
          ),
          body: Center(
            child: StackedCardStack(),
          ),
        ),
      ),
    );
  }
}

class StackedCardStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0.0,
          child: StackedCard(color: Colors.blue, index: 0),
        ),
        Positioned(
          top: 30.0,
          child: StackedCard(color: Colors.red, index: 1),
        ),
        Positioned(
          top: 60.0,
          child: StackedCard(color: Colors.green, index: 2),
        ),
        // Add more Positioned widgets for additional cards
      ],
    );
  }
}

class StackedCard extends StatelessWidget {
  final Color color;
  final int index;

  StackedCard({required this.color, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          'Card $index',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}

void main() {
  runApp(StackedCardsPage());
}
