import 'package:flutter/cupertino.dart';

class ErrorWidgetPage extends StatelessWidget {
  String message;
  String image;

  ErrorWidgetPage({required this.message, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(image),
        SizedBox(
          height: 10,
        ),
        Text(message,),
      ],
    ));
  }
}
