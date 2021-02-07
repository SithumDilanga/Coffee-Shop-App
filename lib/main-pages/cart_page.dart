import 'package:coffee_shop_app/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  //var cartItem = Cart();

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
        return Column(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: ListView.builder(
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
                            child: Image.network(
                              '${cart.items[index].itemImage}',
                              fit: BoxFit.cover, 
                              height: 115,
                            ),
                            
                            //Image.asset('assets/cappuccino.jpg', fit: BoxFit.cover, height: 115,)
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
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
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
                                                    
                                                    // deduct current item price from the total
                                                    cart.deductPriceFromTotal(cart.items[index].itemPrice * cart.items[index].amount);
                                                    
                                                    // remove the current item from the cart
                                                    cart.removeFromCart(index);
                                                    
                                                    // pop out from the alert dialog
                                                    Navigator.of(context).pop();

                                                    Fluttertoast.showToast(
                                                      msg: 'Removed from the cart',
                                                      toastLength: Toast.LENGTH_SHORT,
                                                    );
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
          ),
            ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 3.0,
                      offset: Offset(
                        15.0,
                        15.0
                      ),
                    )
                  ]
                ),
                // color: Colors.grey,
                width: double.infinity,
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${cart.total} LKR',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown[700]
                        ),
                      ),
                      RaisedButton(
                        padding: EdgeInsets.only(top: 12.0, bottom: 12.0, left: 16.0, right: 16.0),
                        color: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0)
                        ),
                        child: Text(
                          'Place Order',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        onPressed: () {

                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return ButtonBarTheme(
                                data: ButtonBarThemeData(
                                  alignment: MainAxisAlignment.center
                                ),
                                child: AlertDialog(
                                  actionsPadding: EdgeInsets.only(bottom: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  title: Center(
                                      child: Text('Select Payment Method')
                                  ),
                                  actions: <Widget>[

                                    Column(
                                      children: <Widget>[
                                        RaisedButton( // yes button
                                          color: Colors.brown, 
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(35)
                                          ),
                                          padding: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
                                          child: Text(
                                            'Pay Online', 
                                            style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white
                                          ),
                                        ),
                                        onPressed: () {
                                                                                            
                                          // pop out from the alert dialog
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    SizedBox(height: 8.0),
                                    RaisedButton(
                                      color: Colors.brown,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                      padding: EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
                                      child: Text( // no button
                                        'Pay Cashier',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                      ]
                                    )
                                  ],
                                ),
                              );
                            }
                          );

                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          ],
        );
      }
      ),
    );
  }
}