import 'package:flutter/material.dart';

class JetErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onPressed;

  const JetErrorWidget({super.key, required this.message, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.withAlpha(10),
            radius: 50,
            child: const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 50,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(message),
            ),
          ),
          ElevatedButton(onPressed: onPressed, child: const Text('Retry'))
        ],
      ),
    );
  }
}
