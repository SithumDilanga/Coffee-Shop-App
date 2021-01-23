import 'package:coffee_shop_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  var cartItem = Cart();

  @override
  Widget build(BuildContext context) {

    var cartItems = Provider.of<Cart>(context);
    // print(cartItems.items[0].itemName);
    // print(cartItems.items.length);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.brown,
      ),
      body: Consumer(
        builder: (BuildContext context, Cart cart, child){
        return ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (BuildContext context, int index){
            print(cart.items[0].itemName);
            print('index : ' + index.toString());
            print(cart.items.length);
            return Card(
              child: ListTile(
                title: Text('${cart.items[index].itemName}'),
                subtitle: Text('${cart.items[index].itemPrice}'),
                trailing: Icon(Icons.arrow_circle_up),
                //onTap: () {},
              ),
            );
          }
        );
      }
      ),
    );
  }
}