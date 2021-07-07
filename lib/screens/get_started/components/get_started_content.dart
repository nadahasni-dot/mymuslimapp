import 'package:flutter/material.dart';

class GetStartedContent extends StatelessWidget {
  final String? text;
  final String? image;

  const GetStartedContent({Key? key, this.text, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text!,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 1),
        Expanded(
          flex: 5,
          child: Image.asset(
            image!,
            height: 200,
            fit: BoxFit.fitHeight,
          ),
        ),
      ],
    );
  }
}
