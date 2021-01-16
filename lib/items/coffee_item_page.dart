import 'package:coffee_shop_app/home/gridview.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CoffeeItem extends StatefulWidget {
  @override
  _CoffeeItemState createState() => _CoffeeItemState();
}

class _CoffeeItemState extends State<CoffeeItem> {
  @override
  Widget build(BuildContext context) { 
    return Material(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/cappuccino.jpg'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget> [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, size: 30,),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 100),
                Card(
                  child: Column(
                    children: <Widget> [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            Text('Cappuccino', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),),

                            Text('240 LKR',style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: HexColor('#5D2300')),),
                          ]
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit', style: TextStyle(fontSize: 14.0, color: Colors.grey),),
                      ),
                    ] 
                  ),
                )
              ]
            ),
          ),          
        ],
      ),
    );
    
    /*MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,//HexColor('#FFFFFF'),
        body: SingleChildScrollView(
          //physics: AlwaysScrollableScrollPhysics(),
          child: Container(
              //constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/cappuccino.jpg'),
                  fit: BoxFit.cover,
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
                    Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('data')
                            ],
                          ),
                        ],
                      )
                    )
                  ],
                ),
              )
            ),
        ),
      )
    );*/
    
    /*MaterialApp(
      home: Scaffold(
        body:SingleChildScrollView(
          child: Container(
                //constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cappuccino.jpg'),
                    fit: BoxFit.contain,
                    alignment: Alignment.topLeft,
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: <Widget> [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      SizedBox(height: 100),
                      Card(
                        child: Column(
                          children: <Widget> [
                            Row(
                              children: <Widget> [
                                Text('data'),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text('data')
                                ),
                              ]
                            ),
                          ] 
                        ),
                      )
                    ]
                  ),
                ),
              ),
        ),
      ),
    );*/
  }
}