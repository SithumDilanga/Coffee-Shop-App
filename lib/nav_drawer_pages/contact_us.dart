import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/black.jpg'),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 8.0),
            child: Column(
              children: <Widget> [
                Row(
                  children: <Widget> [
                    Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(         // back button
                      icon: Icon(Icons.arrow_back, size: 30,),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(width: 16.0,),
                  Text(
                    'Contact Us',
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
                SizedBox(height: 120),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 32.0),
                    child: Column(
                      children: <Widget> [
                        Container(
                          width: double.infinity,
                          child: Text('Phone           : 076056564',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          child: Text('Hotline         : 034561169',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          child: Text('Email            : brewster@gmail.com',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          child: Text('Address       : 22/5 Goal Road, Colombo',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                      ]
                    ),
                  ),
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}