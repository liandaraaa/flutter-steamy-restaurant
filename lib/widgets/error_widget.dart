import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorWidgetPage extends StatelessWidget {
  final String message;
  final String image;

  ErrorWidgetPage({required this.message, required this.image});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image),
          SizedBox(
            height: 10,
          ),
          Text(
            message,
          ),
        ],
      )),
    );
  }
}
