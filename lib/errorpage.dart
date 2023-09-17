import 'package:flutter/material.dart';

import 'main.dart';

class Error_Widget extends StatelessWidget {
  const Error_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    userdata.add("Error");
    print(userdata);
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: 60.0,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              const Text(
                'Error!',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              const Text(
                'Your transaction is complete.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
