import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_library/logic/navigation/route.gr.dart';

// ignore: use_key_in_widget_constructors
class EmailVertificationLobbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app, color: Colors.black),
          onPressed: () {
            AutoRouter.of(context).replace(const LoginScreen());
          },
        ),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Waiting for e-mail vertification...',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 25,
          ),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 14,
          ),
          TextButton(
              onPressed: () {},
              child: const Text('Send request again',
                  style: TextStyle(color: Colors.purple, fontSize: 17)))
        ],
      )),
    );
  }
}
