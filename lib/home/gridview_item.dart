import 'package:coffee_shop_app/items/coffee_item_page.dart';
import 'package:coffee_shop_app/models/product.dart';
import 'package:flutter/material.dart';

class TodaySpecialItem extends StatefulWidget {

  //getting Products data coming from the TodaySpecialGrid
  final Product product;

  TodaySpecialItem({this.product});

  @override
  _TodaySpecialItemState createState() => _TodaySpecialItemState();
}

class _TodaySpecialItemState extends State<TodaySpecialItem> {
  @override
  Widget build(BuildContext context) {
      return Hero(
        tag: widget.product.name,
        child: Card(
            elevation: 3.0,
            child: InkWell(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget> [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
                    child: Image.network(
                      '${widget.product.imgUrl}',
                      fit: BoxFit.cover,
                      height: 100,
                      width: double.maxFinite,
                    )
                    
                    //Image.asset('assets/login-screen-img.jpg',fit: BoxFit.cover, height: 100, width: double.maxFinite,)
                  ),
                  SizedBox(height: 4.0),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0,),
                      child: Text(
                        '${widget.product.name}', 
                        style: TextStyle(
                          fontSize: 20.0, 
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${widget.product.desc}', 
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.0, 
                          color: Colors.grey
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '${widget.product.price} LKR', 
                        style: TextStyle(
                          fontSize: 18.0, 
                          color: Colors.brown[500], 
                          fontWeight: FontWeight.w800
                        )
                      ),
                    ),
                  ),
                ]
              ),
              onTap: () {
                //Navigator.of(context).push(_createRoute(CoffeeItem(product: widget.product,)));
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => CoffeeItem(product: widget.product,)
                  )
                );
              },
            ),
          ),
      );
  }
}

Route _createRoute(var routePage) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => routePage,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
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