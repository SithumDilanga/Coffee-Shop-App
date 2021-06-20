import 'package:coffee_shop_app/views/authenticate/login.dart';
import 'package:coffee_shop_app/views/authenticate/sign_up.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showLogin = true;

  // ---- switching between login and register ----
  void toggleView() {
    // return the inversing bool value of showLogin and rebuild the state
    setState(() => showLogin = !showLogin);
  }
  // ---- End switching between login and register ----

  @override
  Widget build(BuildContext context) {
    return showLogin ? Login() : SignUp();
  }
}