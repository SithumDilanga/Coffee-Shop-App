import 'package:flutter/cupertino.dart';

class Item with ChangeNotifier {

  String itemName;
  double itemPrice;
  int amount;
  var tableNo;

  Item({this.itemName, this.itemPrice, this.amount, this.tableNo});

  // int itemAmount = 1;

  // void increase(int itemCount) {
  //   // itemAmount++;
  //   this.itemAmount = itemCount;
  //   notifyListeners();
  // }

  // void decrease() {
  //   itemAmount--;
  //   notifyListeners();
  // }
  
}