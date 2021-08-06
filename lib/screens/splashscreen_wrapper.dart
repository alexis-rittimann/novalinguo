import 'package:flutter/material.dart';
import 'package:novalinguo/models/user.dart';
import 'package:novalinguo/screens/authenticate/authenticate_screen.dart';
import 'package:provider/provider.dart';
import 'home/home_screen.dart';

class SplashScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return AuthenticateScreen();
    } else {
      return HomeScreen();
    }
  }
}
