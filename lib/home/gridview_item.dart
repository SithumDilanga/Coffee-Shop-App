import 'package:coffee_shop_app/items/coffee_item_page.dart';
import 'package:flutter/material.dart';

class TodaySpecialItem extends StatefulWidget {
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
                  child: Image.asset('assets/login-screen-img.jpg',fit: BoxFit.cover, height: 100, width: double.maxFinite,)
                ),
                SizedBox(height: 8.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Cappucino', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),),
                  ),
                ),
                SizedBox(height: 4.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('lorem ipusum lorem', style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                  ),
                ),
                SizedBox(height: 8.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('250 LKR', style: TextStyle(fontSize: 16.0, color: Colors.brown[500], fontWeight: FontWeight.w500)),
                  ),
                ),
              ]
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => CoffeeItem()
              ));
            },
          ),
        );
  }
}