import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/about-us-img.jpg'),
          Positioned(
            bottom: 2,
            left: 40,
            child: Image.asset(
              'assets/about-us-bg.png',
              height: 300,
            ),
          ),
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
                    'About Us',
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
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vehicula congue leo nec mattis. Integer rhoncus condimentum commodo. Aliquam nec enim sodales, rhoncus lorem id, pellentesque justo. Aliquam nec enim sodales, rhoncus lorem id, pellentesque justo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ]
            ),
          ),
        ],
      ),
    );
  }
}