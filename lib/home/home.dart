import 'package:coffee_shop_app/common/home_buttons.dart';
import 'package:coffee_shop_app/main-pages/cart_page.dart';
import 'package:coffee_shop_app/home/nav_drawer.dart';
import 'package:coffee_shop_app/icons/my_icons.dart';
import 'package:coffee_shop_app/home/gridview.dart';
import 'package:coffee_shop_app/main-pages/coffee_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  // Glabal key for show only burger button for navigation drawer
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
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
                      Padding(    // Coffe Button
                        padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                        child: HomePageMainButtons(
                          MyIcons.coffeIcon, 
                          'Order Coffee', 
                          () {

                            Navigator.of(context).push(_createRoute());

                          /*Navigator.of(context).push(
                            PageRouteBuilder(pageBuilder: (context, animation, _) {
                              return CoffeePage();
                            },
                            opaque: false
                            ),
                          );*/
                          }
                        )
                      ),
                      SizedBox(height: 16.0),
                      Padding(    // Snacks Button
                        padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                        child: HomePageMainButtons(
                          MyIcons.burgerIcon, 
                          'Order Snacks', 
                          () { }
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Padding(      // Desserts Button
                        padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                        child: HomePageMainButtons(
                          MyIcons.iceCreamIcon, 
                          'Order Desserts', 
                          () { }
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

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CoffeePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0.0);
      // var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      // var tween = Tween(begin: begin, end: end);
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}