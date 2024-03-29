import 'package:coffee_shop_app/models/item.dart';
import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier{

  List<Item> items = [];
  List<int> users = [];
  int total = 0;

  void addToCart(Item item) {
    items.add(item);
    notifyListeners();
  }

  void removeFromCart(int index) {
    print('index in cart : ' + index.toString());
    items.removeAt(index);
    notifyListeners();
  }

  void addPriceToTotal(int price) {
    total += price;
    notifyListeners();
  }

  void deductPriceFromTotal(int price) {
    total -= price;
    notifyListeners();
  }
}