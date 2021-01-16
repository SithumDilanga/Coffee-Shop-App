import 'package:coffee_shop_app/home/gridview.dart';
import 'package:flutter/material.dart';

class CoffeePage extends StatefulWidget {
  @override
  _CoffeePageState createState() => _CoffeePageState();
}

class _CoffeePageState extends State<CoffeePage> {
  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,//HexColor('#FFFFFF'),
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
                            Navigator.pop(context);
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
                    TodaySpecialGrid()
                  ],
                ),
              )
            ),
        ),
      )
    );
  }
}