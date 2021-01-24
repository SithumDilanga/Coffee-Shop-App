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
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Card(
                elevation: 3.0,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children:<Widget> [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0)),
                        child: Image.asset('assets/cappuccino.jpg', fit: BoxFit.cover, height: 110,)
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 110,
                        //color: Colors.yellow,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Cappuccino', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
                                IconButton(
                                  icon: Icon(Icons.close), 
                                  onPressed: (){},
                                )
                              ],
                            ),
                          Text('#1', style: TextStyle(fontSize: 16.0),),
                          SizedBox(height: 16.0),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text('240 LKR', style: TextStyle(fontSize: 18.0, color: Colors.brown[500],  fontWeight: FontWeight.w700),)
                            ),
                          ),
                        ],
                        ),
                      ),
                    ),
                  ]
                )
                
                /*ListTile(
                  title: Text('${cart.items[index].itemName}'),
                  subtitle: Text('${cart.items[index].itemPrice}'),
                  trailing: Icon(Icons.arrow_circle_up),
                  //onTap: () {},
                ),*/
              ),
            );
          }
        );
      }
      ),
    );
  }
}