import 'package:coffee_shop_app/models/item.dart';
import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier{

  List<Item> items = [];

  void addToCart(Item item) {
    items.add(item);
    notifyListeners();
  }

  void removeFromCart(Item item) {
    items.remove(item);
    notifyListeners();
  }

}