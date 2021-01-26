import 'package:coffee_shop_app/models/item.dart';
import 'package:flutter/cupertino.dart';

class Cart with ChangeNotifier{

  List<Item> items = [];

  void addToCart(Item item) {
    items.add(item);
    notifyListeners();
  }

  void removeFromCart(int index) {
    print('index in cart : ' + index.toString());
    print(items.remove(index));
    items.remove(index);
    notifyListeners();
  }

}