import 'package:coffee_shop_app/models/product.dart';

class SnackProduct extends Product{

  String category;
  String name;
  int price;
  String desc;
  String imgUrl;
  String timeStamp;

  SnackProduct({this.category, this.name, this.price, this.desc, this.imgUrl, this.timeStamp});

}