import 'package:coffee_shop_app/models/item.dart';

class CartUser {

  final String uid;
  final String name;
  final List<Item> items;
  final int total;
  final bool isItemOnTheWay;

  CartUser({this.uid, this.name, this.items, this.total, this.isItemOnTheWay});

}