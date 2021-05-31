import 'package:coffee_shop_app/models/product.dart';

class CoffeeProduct extends Product{

  String category;
  String name;
  int price;
  String desc;
  String imgUrl;
  String timeStamp;

  CoffeeProduct({this.category, this.name, this.price, this.desc, this.imgUrl, this.timeStamp});

}