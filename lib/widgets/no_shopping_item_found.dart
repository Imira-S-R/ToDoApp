import 'package:flutter/material.dart';

class NoItemFound extends StatelessWidget {
  const NoItemFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height - 200.0,
        ),
        Text(
          'No Shopping Item Added',
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
      ],
    );
  }
}
