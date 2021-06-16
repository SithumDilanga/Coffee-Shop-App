import 'package:coffee_shop_app/home/gridview_item.dart';
import 'package:coffee_shop_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatefulWidget {

  final productCategory;

  ProductGridView({this.productCategory});

  @override
  _ProductGridViewState createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {

  @override
  Widget build(BuildContext context) {

    // // list of coffee products
    // final coffeeProducts = Provider.of<List<Product>>(context, listen: true) ?? [];

    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8.0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2, 
      itemCount: widget.productCategory.length, //coffeeProducts.length
      itemBuilder: (context, index) {
        return ProductGridItem(product: widget.productCategory[index]); //coffeeProducts[index]
      }, 
      staggeredTileBuilder: (index) {
        return StaggeredTile.count(1, index.isEven ? 1.15 : 1.15);
      },
     );
  }
}

