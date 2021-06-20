import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/black.jpg'),
          Positioned(
            bottom: 5,
            left: 50,
            child: Image.asset(
              'assets/contact-us-bg.png',
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
                        const TextRow(
                          contactName: 'Phone', 
                          contactValue: ': 0769898154',
                        ),
                        SizedBox(height: 8.0),
                        const TextRow(
                          contactName: 'Hotline', 
                          contactValue: ': 0349898989',
                        ),
                        SizedBox(height: 8.0),
                        const TextRow(
                          contactName: 'Email', 
                          contactValue: ': brewster@gmail.com',
                        ),
                        SizedBox(height: 8.0),
                        const TextRow(
                          contactName: 'Address', 
                          contactValue: ': 22/5 Goal Road, Colombo',
                        ),
                      ]
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

class TextRow extends StatelessWidget {
  const TextRow({ Key key, this.contactName, this.contactValue }) : super(key: key);

  final String contactName, contactValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          contactName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          )
        ),
        SizedBox(width: 48.0),
        Expanded(
          child: Text(
            contactValue,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
          ),
        )
      ]
    );
  }
}