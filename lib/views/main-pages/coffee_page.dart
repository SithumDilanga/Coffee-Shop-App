import 'package:coffee_shop_app/views/home/product_gridview.dart';
import 'package:coffee_shop_app/models/coffeeProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeePage extends StatefulWidget {
  @override
  _CoffeePageState createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  @override
  Widget build(BuildContext context) {

    // list of coffee products
    final coffeeProducts = Provider.of<List<CoffeeProduct>>(context, listen: true) ?? [];

    return 
    MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.transparent,//HexColor('#FFFFFF'),
        body: SingleChildScrollView(
          //physics: AlwaysScrollableScrollPhysics(),
          child: Container(
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
                    Navigator.of(context).pop();
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
            ProductGridView(productCategory: coffeeProducts,)
          ],
        ),
      )
    ),  
        ),
      )
    );
  }
}