import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Create Customer Account',
            style: TextStyle(fontSize: 20),
          ),
          CircleAvatar(radius: 64, backgroundColor: Colors.green),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Entre Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Entre Full Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Entre Phone Number',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Entre Password',
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
