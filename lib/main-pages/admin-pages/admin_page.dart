import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Colors.brown,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(
                  color: Colors.white
                )
              ),
              child: Text(
                'ADD ITEMS',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Card(
              elevation: 3.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget> [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget> [
                        Text(
                          'SD Live',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        ),
                        Text(
                          '#01',
                          style: TextStyle(
                            fontSize: 20
                          ),
                        )
                      ]
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 48.0),
                      child: Text(
                        'Expresso         :  200 LKR', //TODO: find a way to aling all text
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 48.0),
                      child: Text(
                        'Burger              :  250 LKR',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 48.0),
                      child: Text(
                        'Total                 :  450 LKR',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 145,
                          height: 40,
                          child: RaisedButton(
                            //padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 24.0, right:24.0),
                            color: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0)
                            ),
                            child: Text(  
                              'COMPLETED',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            onPressed: () {}
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 145,
                          height: 40,
                          child: RaisedButton( 
                            //padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 43.0, right:43.0),
                            color: Colors.brown,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0)
                            ),
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            onPressed: () {}
                          ),
                        )
                      ],
                    ),
                  ]
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}