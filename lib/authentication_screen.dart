import 'package:biometric_authentication_app/authentication_service.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bimetric auth "),
          centerTitle: true,
          backgroundColor: Colors.purple.shade100,
        ),
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                Authentication auth = Authentication();
                bool value = await auth.checkBiometrics();
                if (value) {
                  bool isAuth = await auth.authenticateWithBiometrics();

                  if (isAuth) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("auth failed")));
                  }
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("no biometric")));
                }
              },
              child: Text("Click for biometric auth ")),
        ));
  }
}
