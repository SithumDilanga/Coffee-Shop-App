import 'package:flutter/cupertino.dart';

class Item with ChangeNotifier {

  String itemName;
  double itemPrice;

  Item({this.itemName, this.itemPrice});

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