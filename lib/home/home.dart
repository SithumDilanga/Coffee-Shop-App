import 'dart:async';
import 'package:coffee_shop_app/common/home_buttons.dart';
import 'package:coffee_shop_app/main-pages/cart_page.dart';
import 'package:coffee_shop_app/home/nav_drawer.dart';
import 'package:coffee_shop_app/icons/my_icons.dart';
import 'package:coffee_shop_app/home/gridview.dart';
import 'package:coffee_shop_app/main-pages/coffee_page.dart';
import 'package:coffee_shop_app/main-pages/dessert_page.dart';
import 'package:coffee_shop_app/main-pages/snacks_page.dart';
import 'package:coffee_shop_app/models/TodaySpecialsPoroduct.dart';
import 'package:coffee_shop_app/models/coffeeProduct.dart';
import 'package:coffee_shop_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  // Glabal key for show only burger button for navigation drawer
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  var top = 0.0;

  @override
  Widget build(BuildContext context) {


    // list of today special products
    final todaySpecialProducts  = Provider.of<List<TodaySpecialstProduct>>(context, listen: true) ?? [];

    return Scaffold(
      // backgroundColor: Colors.transparent,
        key: _scaffoldState,
        drawer: NavDrawer(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/home-bg4.jpg'),
              colorFilter: ColorFilter.mode(
                Colors.white24,
                BlendMode.modulate
              ),
              fit: BoxFit.cover,
              // alignment: Alignment.topLeft,
            )
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                // expandedHeight: 100,
                backgroundColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart),
                      color: Colors.white,
                      iconSize: 32.0,
                      onPressed: () {
                        
                        Navigator.of(context).push(_createCartRoute(CartPage()));
                      },
                    ),
                  ),
                ],
                pinned: _pinned,
                snap: _snap,
                floating: _floating,
                expandedHeight: 200.0,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {

                    top = constraints.biggest.height;

                    // print('constraints=' + constraints.toString());
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            'assets/home-img.png',
                            fit: BoxFit.cover,
                          )
                        ),
                        // Text('Coffee Shop')
                      ],
                    );
                    /*FlexibleSpaceBar(
                      title: Text('Coffee Shop'),
                      background: Image.asset(
                        'assets/home-img.png',
                        fit: BoxFit.cover,
                      ),
                    );*/
                  }  
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget> [
                    Padding(    // Coffe Button
                      padding: const EdgeInsets.fromLTRB(70.0, 16.0, 70.0, 0),
                      child: HomePageMainButtons(
                        MyIcons.coffeIcon, 
                        'Order Coffee', 
                        () {

                          Navigator.of(context).push(_createRoute(CoffeePage()));

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
                        () {
                          Navigator.of(context).push(_createRoute(SnacksPage()));
                        }
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Padding(      // Desserts Button
                      padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                      child: HomePageMainButtons(
                        MyIcons.iceCreamIcon, 
                        'Order Desserts', 
                        () {
                          Navigator.of(context).push(_createRoute(DessertsPage()));
                        }
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
                    TodaySpecialGrid(productCategory: todaySpecialProducts,)
                  ]
                )
              )
            ],
          ),
        ),

        /*Material(
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

                            Navigator.of(context).push(_createRoute(CoffeePage()));

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
                          () {
                            Navigator.of(context).push(_createRoute(SnacksPage()));
                          }
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Padding(      // Desserts Button
                        padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                        child: HomePageMainButtons(
                          MyIcons.iceCreamIcon, 
                          'Order Desserts', 
                          () {
                            Navigator.of(context).push(_createRoute(DessertsPage()));
                          }
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
                      TodaySpecialGrid(productCategory: coffeeProducts,)
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
        ), */
      );
  }
}

Route _createRoute(var routePage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => routePage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0.0);
      // var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      // var tween = Tween(begin: begin, end: end);
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      //var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createCartRoute(var routePage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => routePage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, -1.0);
      // var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      // var tween = Tween(begin: begin, end: end);
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      //var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
} 