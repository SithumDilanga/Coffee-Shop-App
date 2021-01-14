import 'package:coffee_shop_app/home/gridview_item.dart';
import 'package:flutter/material.dart';

class TodaySpecialGrid extends StatefulWidget {
  @override
  _TodaySpecialGridState createState() => _TodaySpecialGridState();
}

class _TodaySpecialGridState extends State<TodaySpecialGrid> {
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Text('gridview item');/*GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 4.0, ),
      itemBuilder: (BuildContext context, int index) {
        return TodaySpecialItem();
        /*Card(
          child: Center(
            child: Text('Text : ${index}')
          ),
        );*/
      },
    );*/
  }
}