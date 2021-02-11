import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePageMainButtons extends StatelessWidget {

  final IconData icon;
  final String text;
  final Function onTap; 

  HomePageMainButtons(this.icon, this.text, this.onTap) 
  : assert(onTap != null),
    assert(icon != null),
    assert(text != null);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
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
              icon,
              size: 32.0,
              color: HexColor('#5D2300'),
            ),
            SizedBox(width: 16.0,),
            Text(text, style: TextStyle(fontSize: 20.0, color: HexColor('#5D2300')),),
          ],
        ),
      ),
      onPressed: onTap,
    );
  }
}