import 'package:coffee_shop_app/views/authenticate/toggle_auth.dart';
import 'package:coffee_shop_app/views/home/home.dart';
import 'package:coffee_shop_app/models/uid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // listening to streamProvider
    final user = Provider.of<UID>(context);
    // print('User : ' + user.toString());

    // return either Home or Authentication page
    if(user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}