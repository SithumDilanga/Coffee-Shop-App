import 'package:coffee_shop_app/home/gridview_item.dart';
import 'package:coffee_shop_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class TodaySpecialGrid extends StatefulWidget {
  @override
  _TodaySpecialGridState createState() => _TodaySpecialGridState();
}

class _TodaySpecialGridState extends State<TodaySpecialGrid> {

  

  // Future _loadMore(BuildContext context, bool streamListenState) {

  // }

  @override
  Widget build(BuildContext context) {

    // list of coffee products
    final coffeeProducts = Provider.of<List<Product>>(context, listen: true) ?? [];

    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2, 
      itemCount: coffeeProducts.length,
      itemBuilder: (context, index) {
        return TodaySpecialItem(product: coffeeProducts[index]);
      }, 
      staggeredTileBuilder: (index) {
        return StaggeredTile.count(1, index.isEven ? 1.15 : 1.15);
      },
     );
    
    /*GridView.builder(
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