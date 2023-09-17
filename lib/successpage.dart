import 'package:flutter/material.dart';
import 'package:web_stripe/main.dart';

class SuccessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    userdata.add("sucess");
    print(userdata);
    return
      Scaffold(
    //     appBar: AppBar(
    //     title: Text("success"),
    // ),
      body:
      Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 60.0,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              const Text(
                'Success!',
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
      )
      )
    ;


  }
}
