import 'package:coffee_shop_app/icons/my_icons.dart';
import 'package:coffee_shop_app/nav_drawer_pages/about_us.dart';
import 'package:coffee_shop_app/services/auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {

  // instance of a AuthService class to acces authentication methods
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/sign-up-img.jpg'),
                  fit: BoxFit.cover
                )
              ),
            ),

            CustomeListTile(Icons.star_rate, 'Rate App', ()=>{
             /* Share.share(
                ' Motivational Quotes App : '+  
                'https://play.google.com/store/apps/details?id=com.motivational.inspirational.daily.quotes'
              )*/
            }),
            CustomeListTile(Icons.support_agent, 'Contact Us', () {
              //playstore app page
              //StoreRedirect.redirect(androidAppId: 'com.simplevoice.android.voicerecorder');
              String url = 'https://play.google.com/store/apps/developer?id=SD+Live&hl=en';
              /*if (canLaunch(url) != null){
                launch(
                  url
                ); 
              } else {
                throw 'Could not launch $url';
              }*/
            }),
            CustomeListTile(Icons.info, 'About Us', () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
            }),
            CustomeListTile(Icons.logout, 'Log Out', () {

              // -------- logout alert dialog ---------
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    title: Center(
                      child: Text('Log Out ?')
                    ),
                    actions: <Widget>[
                      TextButton( // yes button
                        child: Text(
                          'Yes', 
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.brown[500]
                          ),
                        ),
                        onPressed: () {
                                                    
                          _auth.logOut(); // calling logout method
                          Navigator.of(context).pop();

                        },
                      ),
                      TextButton(
                        child: Text( // no button
                          'No',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.brown[500]
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              );
              // -------- End logout alert dialog ---------
            }),
          ],
        ),
      )
    );
  }
}

class CustomeListTile extends StatelessWidget {

  IconData icon;
  String text;
  Function onTap;

  CustomeListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.brown))
        ),
        child: InkWell(
          splashColor: Colors.brown[300],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Icon(icon, size: 28, color: Colors.brown[700],),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                  child: Text(
                    text, 
                    style: TextStyle(
                      fontSize: 22.0, 
                      color: Colors.brown[900], 
                      //shadows: [Shadow(blurRadius: 7.0, color: Colors.brown[200], offset: Offset(1.0, 1.0),)]
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}