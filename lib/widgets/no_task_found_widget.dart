import 'package:flutter/material.dart';

class NoTaskFound extends StatelessWidget {
  const NoTaskFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height - 290.0,
        ),
        Text(
          'No Tasks Added',
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ],
    );
  }
}
