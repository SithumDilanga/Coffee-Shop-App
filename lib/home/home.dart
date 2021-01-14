import 'package:coffee_shop_app/icons/my_icons.dart';
import 'package:coffee_shop_app/home/gridview.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          //physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/home-img.png'
              ),
              SizedBox(height: 32.0),
              Padding(    // TODO: Refactor later this code block into a common widget
                padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                child: RaisedButton(
                  color: Colors.brown[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                     child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          MyIcons.coffeIcon,
                          size: 32.0,
                          color: HexColor('#5D2300'),
                        ),
                        SizedBox(width: 16.0,),
                        Text('Order Coffee', style: TextStyle(fontSize: 20.0, color: HexColor('#5D2300')),),
                      ],
                    ),
                  ),
                  onPressed:() {}
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                child: RaisedButton(
                  color: Colors.brown[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                     child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          MyIcons.burgerIcon, // TODO: adjust icon weigth and size
                          size: 32.0,
                          color: HexColor('#5D2300'),
                        ),
                        SizedBox(width: 16.0,),
                        Text('Order Snacks', style: TextStyle(fontSize: 20.0, color: HexColor('#5D2300')),),
                      ],
                    ),
                  ),
                  onPressed:() {}
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(70.0, 0, 70.0, 0),
                child: RaisedButton(
                  color: Colors.brown[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 16.0),
                     child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          MyIcons.iceCreamIcon,
                          size: 32.0,
                          color: HexColor('#5D2300'),
                        ),
                        SizedBox(width: 16.0,),
                        Text('Order Desserts', style: TextStyle(fontSize: 20.0, color: HexColor('#5D2300')),),
                      ],
                    ),
                  ),
                  onPressed:() {}
                ),
              ),
              SizedBox(height: 24.0,),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Today Special', 
                    style: TextStyle(fontSize: 14.0, color: Colors.grey, fontWeight: FontWeight.w700),)
                ),
              ),
              //SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: TodaySpecialGrid(),
              )
            ],
          ),
        ),
      ),
    );
  }
}