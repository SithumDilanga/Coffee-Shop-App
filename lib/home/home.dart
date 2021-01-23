import 'package:coffee_shop_app/main-pages/cart_page.dart';
import 'package:coffee_shop_app/home/nav_drawer.dart';
import 'package:coffee_shop_app/icons/my_icons.dart';
import 'package:coffee_shop_app/home/gridview.dart';
import 'package:coffee_shop_app/main-pages/coffee_page.dart';
import 'package:coffee_shop_app/models/item.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  // Glabal key for show only burger button for navigation drawer
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        drawer: NavDrawer(),
        body: Material(
          child: SingleChildScrollView(
              child: SingleChildScrollView(
                //physics: AlwaysScrollableScrollPhysics(),
                child: Stack(
                  children: <Widget> [
                    Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/home-img.png'
                      ),
                      SizedBox(height: 32.0),
                      Padding(    // TODO: Refactor later this code block into a common widget
                        padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                        child: RaisedButton(
                          color: Colors.brown[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                             child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  MyIcons.coffeIcon,
                                  size: 32.0,
                                  color: HexColor('#5D2300'),
                                ),
                                SizedBox(width: 16.0,),
                                Text('Order Coffee', style: TextStyle(fontSize: 20.0, color: HexColor('#5D2300')),),
                              ],
                            ),
                          ),
                          onPressed:() {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => CoffeePage()
                            ));
                          }
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                        child: RaisedButton(
                          color: Colors.brown[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                             child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  MyIcons.burgerIcon, // TODO: adjust icon weigth and size
                                  size: 32.0,
                                  color: HexColor('#5D2300'),
                                ),
                                SizedBox(width: 16.0,),
                                Text('Order Snacks', style: TextStyle(fontSize: 20.0, color: HexColor('#5D2300')),),
                              ],
                            ),
                          ),
                          onPressed:() {
                            // var item = context.read<Item>();
                            // item.add();
                          }
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                        child: RaisedButton(
                          color: Colors.brown[200],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                             child: Row(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  MyIcons.iceCreamIcon,
                                  size: 32.0,
                                  color: HexColor('#5D2300'),
                                ),
                                SizedBox(width: 16.0,),
                                Text('Order Desserts', style: TextStyle(fontSize: 20.0, color: HexColor('#5D2300')),),
                              ],
                            ),
                          ),
                          onPressed:() {}
                        ),
                      ),
                      SizedBox(height: 24.0,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Today Special', 
                            style: TextStyle(fontSize: 14.0, color: Colors.grey, fontWeight: FontWeight.w700),)
                        ),
                      ),
                      //SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: TodaySpecialGrid(),
                      )
                    ],
                  ),
                  // Burger icon and cart icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:<Widget> [
                      Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 32.0),
                    child: IconButton(
                      icon: Icon(Icons.menu),
                      color: Colors.white, 
                      iconSize: 32.0,
                      onPressed: () {
                        _scaffoldState.currentState.openDrawer();
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 32.0),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Colors.white,
                      iconSize: 32.0,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                      },
                    ),
                  ),
                    ]
                  ),
                ]
                ),
              ),
            ),
        ),
      );
  }
}