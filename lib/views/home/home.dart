import 'package:coffee_shop_app/common/home_buttons.dart';
import 'package:coffee_shop_app/common/route_transition.dart';
import 'package:coffee_shop_app/views/main-pages/cart_page.dart';
import 'package:coffee_shop_app/views/nav_drawer_pages/nav_drawer.dart';
import 'package:coffee_shop_app/icons/my_icons.dart';
import 'package:coffee_shop_app/views/home/product_gridview.dart';
import 'package:coffee_shop_app/views/main-pages/coffee_page.dart';
import 'package:coffee_shop_app/views/main-pages/dessert_page.dart';
import 'package:coffee_shop_app/views/main-pages/snacks_page.dart';
import 'package:coffee_shop_app/models/TodaySpecialsPoroduct.dart';
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

  RouteTransition routeTransition = RouteTransition();

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
                        // Navigator.of(context).push(_createCartRoute(CartPage()));
                        Navigator.of(context).push(
                          routeTransition.createRoute(CartPage(), 0.0, -1.0)
                        );
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
                            'assets/home-img2.png',
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
                          // Navigator.of(context).push(_createRoute(CoffeePage()));
                          Navigator.of(context).push(
                            routeTransition.createRoute(CoffeePage(), -1.0, 0.0)
                          );
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
                          // Navigator.of(context).push(_createRoute(SnacksPage()));
                          Navigator.of(context).push(
                            routeTransition.createRoute(SnacksPage(), -1.0, 0.0)
                          );
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
                          // Navigator.of(context).push(_createRoute(DessertsPage()));
                          Navigator.of(context).push(
                            routeTransition.createRoute(DessertsPage(), -1.0, 0.0)
                          );
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
                    ProductGridView(productCategory: todaySpecialProducts,)
                  ]
                )
              )
            ],
          ),
        ),
      );
  }
}