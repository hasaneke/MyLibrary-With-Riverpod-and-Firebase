import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 25,
          height: 1,
          color: Colors.black,
        ),
        const Text(
          'Welcome to My Library',
          style: TextStyle(fontSize: 27),
        ),
        Container(
          width: 25,
          height: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
