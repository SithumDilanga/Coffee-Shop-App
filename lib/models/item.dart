import 'package:flutter/cupertino.dart';

class Item with ChangeNotifier {

  String itemName;
  double itemPrice;
  int amount;
  var tableNo;

  Item({this.itemName, this.itemPrice, this.amount, this.tableNo});
  
}