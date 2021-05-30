import 'package:flutter/cupertino.dart';

class Item with ChangeNotifier {

  String itemName;
  int itemPrice;
  int amount;
  var tableNo;
  String itemDescription;
  String itemImage;

  Item({this.itemName, this.itemPrice, this.amount, this.tableNo, this.itemDescription, this.itemImage});
  
}