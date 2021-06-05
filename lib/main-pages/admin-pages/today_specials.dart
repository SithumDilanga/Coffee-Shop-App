import 'package:coffee_shop_app/models/SnackProduct.dart';
import 'package:coffee_shop_app/models/coffeeProduct.dart';
import 'package:coffee_shop_app/models/dessertProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToTodaySpecials extends StatefulWidget {
  const AddToTodaySpecials({ Key key }) : super(key: key);

  @override
  _AddToTodaySpecialsState createState() => _AddToTodaySpecialsState();
}

class _AddToTodaySpecialsState extends State<AddToTodaySpecials> {
  @override
  Widget build(BuildContext context) {

    // list of coffee products
    final coffeeProducts = Provider.of<List<CoffeeProduct>>(context, listen: true) ?? [];

    // list of coffee products
    final dessertProducts = Provider.of<List<DessertProduct>>(context, listen: true) ?? [];

    // list of coffee products
    final snackProducts = Provider.of<List<SnackProduct>>(context, listen: true) ?? [];

    // counting all the available products
    int totalItemsCount = coffeeProducts.length + dessertProducts.length + snackProducts.length;

    coffeeProducts.forEach((product) {
      print('bitch pls ' + product.name.toString());
    });

    return Material(
      child: ListView.builder(
        itemCount: coffeeProducts.length,
        itemBuilder: (context, index) {
          return Text(
            '${coffeeProducts[index].name}',
            style: TextStyle(
              color: Colors.black
            ),
          );
        }
      ),
    );
  }
}