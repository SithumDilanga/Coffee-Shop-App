import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop_app/main-pages/admin-pages/add_item.dart';
import 'package:coffee_shop_app/models/cart.dart';
import 'package:coffee_shop_app/models/item.dart';
import 'package:coffee_shop_app/models/user.dart';
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

  // fetching current user's name from the database
  Future<String> _getCurrentUserName() async{
    return await database.getCurrentUserName(auth.currentUser.uid);
    //print('usernam ' + currentUserName.toString());
  }


  @override
  Widget build(BuildContext context) {

    int count;

    // getting currentCartUsers count from the database 
    // TODO: send this to DataBaseSevice class
    database.currentCartUsers.doc('ux126').get().then((value) {
      count = value.data()['count'];
      print('count value ' + count.toString());
    });

    // final users = Provider.of<List<UserData>>(context);

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
        future: _getCurrentUserName(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Consumer(
          builder: (BuildContext context, Cart cart, _) {
            return ListView.builder(
            itemCount: count,//cart.items.length,
            itemBuilder: (BuildContext context, int index) {

              if(index == 0) {
                print('first time');
              } else {
                cart.items[index].tableNo == cart.items[index - 1].tableNo ? print('gg') : print('nope');
              }

              

              if(snapshot.hasData) {
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
                            Text(
                              '${snapshot.data.toString()}',
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
                              for(var item in cart.items) 
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${item.itemName}'),
                                      SizedBox(width: 32.0),
                                      Text('${item.itemPrice}'),
                                    ],
                                  ),
                                )
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
                                //padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0, right:24.0),
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
                                //padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 43.0, right:43.0),
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
              } else {
                return Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: CupertinoActivityIndicator(),
                );
              }
            },
          );
          },
        );
        },
      ),
    );
  }
}