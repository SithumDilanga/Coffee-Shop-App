import 'package:coffee_shop_app/authenticate/login.dart';
import 'package:coffee_shop_app/authenticate/sign_up.dart';
import 'package:coffee_shop_app/models/cart.dart';
import 'package:coffee_shop_app/models/item.dart';
import 'package:coffee_shop_app/models/user.dart';
import 'package:coffee_shop_app/services/auth.dart';
import 'package:coffee_shop_app/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      //create: (context) => Item(),
      create: (context) => Cart(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      value: AuthService().user,
      child: 
      MaterialApp(
        home: Wrapper(), //SignUp()
      )
    );
  }
}

