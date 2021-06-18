import 'package:coffee_shop_app/models/SnackProduct.dart';
import 'package:coffee_shop_app/models/TodaySpecialsPoroduct.dart';
import 'package:coffee_shop_app/models/coffeeProduct.dart';
import 'package:coffee_shop_app/models/dessertProduct.dart';
import 'package:coffee_shop_app/services/database.dart';
import 'package:coffee_shop_app/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class RemoveProducts extends StatefulWidget {
  const RemoveProducts({ Key key }) : super(key: key);

  @override
  _RemoveProductsState createState() => _RemoveProductsState();
}

class _RemoveProductsState extends State<RemoveProducts> {

  @override
  Widget build(BuildContext context) {

    // list of coffee products
    final coffeeProducts = Provider.of<List<CoffeeProduct>>(context, listen: true) ?? [];

    // list of coffee products
    final dessertProducts = Provider.of<List<DessertProduct>>(context, listen: true) ?? [];

    // list of coffee products
    final snackProducts = Provider.of<List<SnackProduct>>(context, listen: true) ?? [];

    // counting all the available products
    int totalItemsCount = coffeeProducts.length + dessertProducts.length + snackProducts.length;


    return Material(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Today Specials'),
            backgroundColor: Colors.brown,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  // icon: Icon(Icons.directions_bike),
                  text: 'COFFEE',
                ),
                Tab(
                  // icon: Icon(Icons.directions_transit),
                  text: 'SNACKS',
                ),
                Tab(
                  // icon: Icon(Icons.directions_car),
                  text: 'DESSERTS',
                ),
              ],
            ),
          ),
          body: TabBarView( // TabBar contents
            children: [
              // Coffee content
              Padding(  
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: coffeeProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCardView(  // cardview
                      productCategory: coffeeProducts[index].category,
                      productItem: coffeeProducts[index],
                    );

                  },
                ),
              ),
              // snacks content
              Padding(  
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snackProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCardView(
                      productCategory: snackProducts[index].category,
                      productItem: snackProducts[index],
                    );
                  },
                ),
              ),
              // desserts content
              Padding(  
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: dessertProducts.length,
                  itemBuilder: (context, index) {
                    return ProductCardView(
                      productCategory: dessertProducts[index].category,
                      productItem: dessertProducts[index],
                    );
                  },
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class ProductCardView extends StatefulWidget {

  final String productCategory;
  final productItem;

  const ProductCardView({ Key key, this.productItem, this.productCategory}) : super(key: key);

  @override
  _ProductCardViewState createState() => _ProductCardViewState();
}

class _ProductCardViewState extends State<ProductCardView> {
    
  // for checkbox
  bool isChecked = false;
  
  DataBaseService database = DataBaseService();
  Storage storage = Storage();

  @override
  Widget build(BuildContext context) {

    // added product names list
    List<String> nameList = [];

    // list of today special products
    final todaySpecialProducts  = Provider.of<List<TodaySpecialstProduct>>(context, listen: true) ?? [];

    // loop throught every todaySpecialProducts elements
    todaySpecialProducts.forEach((element) {
      nameList.add(element.name); // adding to the local list
    });

    // for checkbox
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.brown;

    }

    return Card(
      elevation: 3.0,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children:<Widget> [
          // ------------ image ----------
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), bottomLeft: Radius.circular(4.0)),
              child: Image.network(
                '${widget.productItem.imgUrl}',
                fit: BoxFit.cover, 
                height: 115,
              ),
            ),
          ),
          // ------------ End image ----------
          SizedBox(width: 8.0),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '${widget.productItem.name}',
                    style: TextStyle(
                      fontSize: 18.0, 
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    '${widget.productItem.price} LKR',
                    style: TextStyle(
                      fontSize: 18.0, 
                      color: Colors.brown[500],  
                      fontWeight: FontWeight.w700
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            flex: 1,
            child: IconButton(
              icon: Icon(Icons.close_rounded),
              onPressed: () {
                print(widget.productCategory.toString());
                print(widget.productItem.name.toString());

                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog( 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      title: const Text(
                        'Are you sure you want to delete this item ?'
                      ),
                      actions: [

                        TextButton( // Yes button
                          child: Text(
                            'Yes', 
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.brown[500]
                            ),
                          ),
                          onPressed: () {
                            // remove product
                            database.removeProduct(
                              widget.productCategory, 
                              widget.productItem.name
                            );

                            // product should also remove from today's special- 
                            //collection if it is available there
                            database.removeTodaySpecialProduct(widget.productItem.name);

                            storage.deleteProductImage(widget.productItem.name + '.jpg');

                            // pop out from the alert dialog
                            Navigator.of(context).pop();

                            Fluttertoast.showToast(
                              msg: 'Item Removed!',
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          }
                        ),
                        TextButton( // No button
                          child: Text(
                            'No', 
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.brown[500]
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }
                        )
                      ],
                    );
                  }
                );
              }, 
            )
          )
        ]
      )
    );
  }
}