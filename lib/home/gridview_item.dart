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
                SizedBox(height: 8.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
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
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CoffeeItem(product: widget.product,)
              ));
            },
          ),
        );
  }
}