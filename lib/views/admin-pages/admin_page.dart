import 'package:coffee_shop_app/common/route_transition.dart';
import 'package:coffee_shop_app/views/admin-pages/add_item.dart';
import 'package:coffee_shop_app/views/admin-pages/remove_products.dart';
import 'package:coffee_shop_app/views/admin-pages/today_specials.dart';
import 'package:coffee_shop_app/models/cart.dart';
import 'package:coffee_shop_app/models/cart_user.dart';
import 'package:coffee_shop_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  
  FirebaseAuth auth = FirebaseAuth.instance;
  // print(auth.currentUser.email);

  DataBaseService database = DataBaseService();
  RouteTransition routeTransition = RouteTransition();

  // cart user's ordered items
  var allItems = [];

  // fetching current user's name from the database
  Future<String> _getCurrentUserName() async{
    return await database.getCurrentUserName(auth.currentUser.uid);
    //print('usernam ' + currentUserName.toString());
  }

  // Future<int> getCartUser() async {
  //   return await database.getCurrentCartUserCount();
  // }

  @override
  Widget build(BuildContext context) {

    final cartUsers  = Provider.of<List<CartUser>>(context, listen: true) ?? [];

    List<String> allCartUserids = [];

     cartUsers.forEach((element) {
       allCartUserids.add(element.uid);
    });


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
                side: BorderSide(
                  color: Colors.white
                )
              ),
              child: Text(
                'Add Items'
              ),
              onPressed: () {
                // Navigator.of(context).push(_createRoute(AddItem()));
                Navigator.of(context).push(
                  routeTransition.createRoute(AddItem(), -1.0, -1.0)
                );
                
              }, 
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4.0, 10.0, 2.0, 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
                side: BorderSide(
                  color: Colors.white
                )
              ),
              child: Text(
                'Today Specials'
              ),
              onPressed: () {
                // Navigator.of(context).push(_createRoute(AddToTodaySpecials()));
                Navigator.of(context).push(
                  routeTransition.createRoute(AddToTodaySpecials(), -1.0, -1.0)
                );
                  
              }, 
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Navigator.of(context).push(_createRoute(RemoveProducts()));
              Navigator.of(context).push(
                  routeTransition.createRoute(RemoveProducts(), -1.0, -1.0)
                );
                 
            }, 
          ),
        ],
      ),
      body: FutureBuilder(
        // Waits for multiple futures to complete and collects their results.
        future: Future.wait([
          _getCurrentUserName(), 
          database.getCurrentCartUserCount(), 
          database.getCurrentCartUsersItems(allCartUserids)
        ]
        ),//_getCurrentUserName(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          return Consumer(
          builder: (BuildContext context, Cart cart, _) {

            // check whether is there any active current cart users
            if(cartUsers.isNotEmpty) { //database.currentCartUsersCount != 0

              if(snapshot.hasData) {
        
                // getting all cart user's ordered items
                allItems = snapshot.data[2];

              return ListView.builder(
                itemCount: cartUsers.length, //snapshot.data[1], // current cart user's count
                itemBuilder: (BuildContext context, int index) {
                  
                  // check whether there is a cart user
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                        child: Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget> [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //TODO: retrive data from cart user's(snapshot.data[2])
                                    // current cart username
                                    // ${snapshot.data[0].toString()}
                                    Text(
                                      '${cartUsers[index].name}', 
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    ),
                                    Text(
                                      // getting first ordered item's table number and set it as tableNo to be ordered
                                      //allItems.first['tableNo']
                                      '#${allItems[index].first['tableNo']}',
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                    )
                                  ]
                                ),
                                SizedBox(height: 16.0),
                                Container(
                                  width: double.infinity,
                                  // padding: EdgeInsets.only(left: 48.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      // Text('snapshot data 2 test ${snapshot.data[2][0]['itemName']}'),

                                      // print('yeah ' + item['itemName'].toString());
                                    //for(int userCount = 0; userCount < cartUsers.length; userCount++)

                                      // loop through each user's cart items
                                      for(var item in allItems[index])
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              
                                              Text('${item['itemName']}'), //item['itemName']
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.close,
                                                    size: 12,
                                                  ),
                                                  Text('${item['itemAmount']}'),
                                                  //item['itemAmount']
                                                ],
                                              ),
                                              SizedBox(width: 32.0),
                                              Text('${item['itemPrice']}'),
                                              // Text('${item['itemName'] * item['itemAmount']}'),
                                              //item['itemName'] * item['itemAmount']
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('Total'),
                                              SizedBox(width: 32.0),
                                              Text('${cartUsers[index].total}'),
                                            ],
                                          ),
                                        ),
                                    ]
                                  ),
                                ),
                                SizedBox(height: 24.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 145,
                                      height: 40,
                                      child: RaisedButton(
                                        //padding: EdgeInsets.only(top: 10.0, bottom: 100,       left:   24.0, right:24.0),
                                        color: Colors.brown,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(35.0)
                                        ),
                                        child: Text(  
                                          'COMPLETED',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        onPressed: () {

                                          database.removeCurrentCartUsersItem(allCartUserids[index]);

                                          // set isCartUser to false
                                          database.setIsCartUser(allCartUserids[index], false);

                                          Fluttertoast.showToast(
                                            msg: '${snapshot.data[0]} Order Completed',
                                            toastLength: Toast.LENGTH_SHORT,
                                          );

                                        }
                                      ),
                                    ),
                                    ButtonTheme(
                                      minWidth: 145,
                                      height: 40,
                                      child: RaisedButton( 
                                        //padding: EdgeInsets.only(top: 10.0, bottom: 100,       left:   43.0, right:43.0),
                                        color: Colors.brown,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(35.0)
                                        ),
                                        child: Text(
                                          'CANCEL',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        onPressed: () {}
                                      ),
                                    )
                                  ],
                                ),
                              ]
                            ),
                          ),
                        ),
                      );

                  
                },
            );
              } else {
                return Align(
                  alignment: Alignment(0.0, -0.5),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: CupertinoActivityIndicator(),
                  ),
                );
              }

            } else { // if cart items are empty then show this

              print(cart.items);
                return Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No Orders Yet!',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600]
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Image.asset(
                      'assets/admin-no-orders.png',
                      height: 180,
                    )
                  ],
                ),
                );

            }            
          },
        );
        },
      ),
    );
  }
}