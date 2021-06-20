import 'package:coffee_shop_app/common/route_transition.dart';
import 'package:coffee_shop_app/views/admin-pages/admin_page.dart';
import 'package:coffee_shop_app/views/nav_drawer_pages/about_us.dart';
import 'package:coffee_shop_app/views/nav_drawer_pages/contact_us.dart';
import 'package:coffee_shop_app/services/auth.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {

  // instance of a AuthService class to acces authentication methods
  final AuthService _auth = AuthService();
  RouteTransition routeTransition = RouteTransition();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/home-bg4.jpg'),
              colorFilter: ColorFilter.mode(
                Colors.white10,
                BlendMode.modulate
              ),
              fit: BoxFit.cover,
              // alignment: Alignment.topLeft,
            )
          ),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/drawer-img3.jpg'),
                  fit: BoxFit.cover
                )
              ),
            ),

            // rate app
            CustomeListTile(Icons.admin_panel_settings, 'Admin Panel', () {
              // Navigator.of(context).push(_createRoute(AdminPage()));
              Navigator.of(context).push(
                routeTransition.createRoute(AdminPage(), -1.0, 0.0)
              );
            }),

            // contact us
            CustomeListTile(Icons.support_agent, 'Contact Us', () {
              // Navigator.of(context).push(_createRoute(ContactUs()));
              Navigator.of(context).push(
                routeTransition.createRoute(ContactUs(), -1.0, 0.0)
              );
            }),

            // about us
            CustomeListTile(Icons.info, 'About Us', () {
              // Navigator.of(context).push(_createRoute(AboutUs()));
              Navigator.of(context).push(
                routeTransition.createRoute(AboutUs(), -1.0, 0.0)
              );
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

  final IconData icon;
  final String text;
  final Function onTap;

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