import 'package:coffee_shop_app/home/product_gridview.dart';
import 'package:coffee_shop_app/home/home.dart';
import 'package:flutter/material.dart';

class CoffeePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/coffee-beans-background.jpg'),
          fit: BoxFit.contain,
          alignment: Alignment.topLeft,
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 32.0),
        child: Column(
          children:<Widget> [
            Row(
              children:<Widget> [
                IconButton(
                  icon: Icon(Icons.arrow_back, size: 30,), 
                  color: Colors.white,
                  onPressed: () {
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                    Navigator.of(context).pushReplacement(_createRoute());
                  }
                ),
                SizedBox(width: 16.0),
                Text(
                  'Coffee',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        // offset: Offset(1.0,1.0),
                      )
                    ],
                  ),
                )
              ]
            ),
            SizedBox(height: 50.0),
            ProductGridView()
          ],
        ),
      )
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Home(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var end = Offset(-1.0, 0.0);
      // var begin = Offset(0.0, 1.0);
      var begin = Offset.zero;
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