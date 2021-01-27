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
            //print(cart.items[0].itemName);
            // print('index : ' + index.toString());
            // print(cart.items.length);
            return Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Card(
                elevation: 3.0,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children:<Widget> [
                    // ------------ image ----------
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0)),
                        child: Image.asset('assets/cappuccino.jpg', fit: BoxFit.cover, height: 115,)
                      ),
                    ),
                    // ------------ End image ----------
                    SizedBox(width: 8.0),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 115,
                        //color: Colors.yellow,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // ---------- title and close button --------
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(cart.items[index].itemName, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),),
                                IconButton(
                                  icon: Icon(Icons.close), 
                                  onPressed: (){

                                    // ------- alert dialog --------
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Center(
                                            child: Text('Remove from the cart ?')
                                          ),
                                          actions: <Widget>[
                                            TextButton( // yes button
                                              child: Text(
                                                'Yes', 
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.brown[500]
                                                ),
                                              ),
                                              onPressed: () {
                                                cartItems.removeFromCart(index);
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text( // no button
                                                'No',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.brown[500]
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      }
                                    );
                                    // ------- End alert dialog --------
                                  },
                                )
                              ],
                            ),
                            // ---------- End title and close button --------
                            
                            // ---------- amount and tableNo -----------
                          Row(
                            children: [
                              Icon(Icons.close, size: 12.0,),
                              Text('${cart.items[index].amount}'),
                              SizedBox(width: 16.0),
                              Text('#${cart.items[index].tableNo}', style: TextStyle(fontSize: 16.0),),
                            ],
                          ),
                          // ---------- End amount and tableNo -----------
                          SizedBox(height: 16.0),

                          // ---------- item price -----------
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text('${cart.items[index].itemPrice} LKR', style: TextStyle(fontSize: 18.0, color: Colors.brown[500],  fontWeight: FontWeight.w700),)
                            ),
                          ),
                          // ---------- End item price -----------
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