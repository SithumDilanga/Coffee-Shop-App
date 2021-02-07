import 'package:flutter/cupertino.dart';

class Item with ChangeNotifier {

  String itemName;
  double itemPrice;
  int amount;
  var tableNo;
  String itemDescription;
  String itemImage;

  Item({this.itemName, this.itemPrice, this.amount, this.tableNo, this.itemDescription, this.itemImage});
  
}