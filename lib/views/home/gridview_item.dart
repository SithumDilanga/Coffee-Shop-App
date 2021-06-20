import 'package:coffee_shop_app/common/route_transition.dart';
import 'package:coffee_shop_app/views/main-pages/product_item_page.dart';
import 'package:coffee_shop_app/models/product.dart';
import 'package:flutter/material.dart';

class ProductGridItem extends StatefulWidget {

  //getting Products data coming from the TodaySpecialGrid
  final Product product;

  ProductGridItem({this.product});

  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {

    RouteTransition routeTransition = RouteTransition();

  @override
  Widget build(BuildContext context) {
      return Card(
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
              // Navigator.of(context).push(_createRoute(CoffeeItem(product: widget.product,)));
              Navigator.of(context).push(
                routeTransition.createRoute(ProductItem(product: widget.product,), 0.0, 1.0)
              );
            },
          ),
        );
  }
}