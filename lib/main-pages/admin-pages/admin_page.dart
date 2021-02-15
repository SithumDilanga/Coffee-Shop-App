import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/main-pages/admin-pages/add_item.dart';
import 'package:coffee_shop_app/models/cart.dart';
import 'package:coffee_shop_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  
  FirebaseAuth auth = FirebaseAuth.instance;
  // print(auth.currentUser.email);

  DataBaseService database = DataBaseService();

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Colors.brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Colors.white
                )
              ),
              child: Text(
                'ADD ITEMS',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddItem()));
              },
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        // Waits for multiple futures to complete and collects their results.
        future: Future.wait([
          _getCurrentUserName(), 
          database.getCurrentCartUserCount(), 
          database.getCurrentCartUsers(auth.currentUser.uid)]
        ),//_getCurrentUserName(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          return Consumer(
          builder: (BuildContext context, Cart cart, _) {

            // check whether is there any active current cart users
            if(database.currentCartUsersCount != 0) { // cart.items.isNotEmpty

              if(snapshot.hasData) {
        
                // getting all cart user's ordered items
                allItems = snapshot.data[2];

              return ListView.builder(
                itemCount: snapshot.data[1], // current cart user's count
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
                                  Text(
                                    '${snapshot.data[0].toString()}', // current cart username
                                    style: TextStyle(
                                      fontSize: 20
                                    ),
                                  ),
                                  Text(
                                    '#${cart.items[index].tableNo}',
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
                                    for(var item in allItems) 
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${item['itemName']}'),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.close,
                                                  size: 12,
                                                ),
                                                Text('${item['itemAmount']}'),
                                              ],
                                            ),
                                            SizedBox(width: 32.0),
                                            Text('${item['itemName'] * item['itemAmount']}'),
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
                                            Text('${cart.total}'),
                                          ],
                                        ),
                                      ),

                                    /*for(var item in cart.items) 
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('${item.itemName}'),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.close,
                                                  size: 12,
                                                ),
                                                Text('${item.amount}'),
                                              ],
                                            ),
                                            SizedBox(width: 32.0),
                                            Text('${item.itemPrice * item.amount}'),
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
                                            Text('${cart.total}'),
                                          ],
                                        ),
                                      ),*/
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
                                      onPressed: () {}
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
                      alignment: Alignment(0.1, -0.6),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: CupertinoActivityIndicator(),
                      ),
                    );
                  }

            } else { // if cart items are empty then show this

              print(cart.items);
                return Center(
                  child: Text(
                    'No Orders Yet!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600]
                    ),
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