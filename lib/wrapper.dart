import 'package:flutter/material.dart';
import 'screens/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:provider/provider.dart";
import 'screens/options.dart';

class Wrapper extends StatelessWidget {
  final auth =FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var user=Provider.of<User>(context);


    bool loggedIn= user !=null;
    if (user== null){
      return onboardingScreen();
    } else {
      return MyHomepage();
    }
  }
}
