import 'package:coffee_shop_app/models/SnackProduct.dart';
import 'package:coffee_shop_app/models/coffeeProduct.dart';
import 'package:coffee_shop_app/models/dessertProduct.dart';
import 'package:coffee_shop_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddToTodaySpecials extends StatefulWidget {
  const AddToTodaySpecials({ Key key }) : super(key: key);

  @override
  _AddToTodaySpecialsState createState() => _AddToTodaySpecialsState();
}

class _AddToTodaySpecialsState extends State<AddToTodaySpecials> {

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

    coffeeProducts.forEach((product) {
      print('bitch pls ' + product.name.toString());
    });

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
                    return TodaySpecialCardView(  // cardview
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
                    return TodaySpecialCardView(
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
                    return TodaySpecialCardView(
                      productItem: dessertProducts[index],
                    );
                  },
                ),
              ),
            ]
          ),
        ),
      ),
      // child: ListView.builder(
      //   itemCount: coffeeProducts.length,
      //   itemBuilder: (context, index) {
      //     return Text(
      //       '${coffeeProducts[index].name}',
      //       style: TextStyle(
      //         color: Colors.black
      //       ),
      //     );
      //   }
      // ),
    );
  }
}

class TodaySpecialCardView extends StatefulWidget {

  final productItem;

  const TodaySpecialCardView({ Key key, this.productItem }) : super(key: key);

  @override
  _TodaySpecialCardViewState createState() => _TodaySpecialCardViewState();
}

class _TodaySpecialCardViewState extends State<TodaySpecialCardView> {

  // for checkbox
  bool isChecked = false;

  DataBaseService database = DataBaseService();

  @override
  Widget build(BuildContext context) {

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
            child: Checkbox(
              value: isChecked, 
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              onChanged: (bool value) {

                if(value == true) {
                  print('true');

                  database.setTodaySpecialsProducts(
                    widget.productItem.category, 
                    widget.productItem.name, 
                    widget.productItem.price, 
                    widget.productItem.desc, 
                    widget.productItem.imgUrl
                  );

                } else {
                  print('false');

                  database.removeTodaySpecialProduct(widget.productItem.name);

                }

                setState(() {
                  isChecked = value;
                });
              },
            ),
          )
        ]
      )
    );
  }
}