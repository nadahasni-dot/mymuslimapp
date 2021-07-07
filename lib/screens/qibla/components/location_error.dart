import 'package:flutter/material.dart';
import 'package:my_muslim_app/constants.dart';

class LocationErrorWidget extends StatelessWidget {
  final String text;
  final Function callback;
  const LocationErrorWidget(
      {Key? key, required this.text, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(PRIMARY_COLOR)),
              child: Text(
                'Coba Lagi',                
              ),
              onPressed: callback as void Function(),
            ),
          )
        ],
      ),
    );
  }
}
