import 'package:coffee_shop_app/authenticate/sign_up.dart';
import 'package:coffee_shop_app/common/loading.dart';
import 'package:coffee_shop_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // instance of AuthService class to get the signin function
  final AuthService _auth = AuthService();

  // to identify the form
  final _formKey = GlobalKey<FormState>();

  // text fields state 
  String email = '';
  String password = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // if loading is true it shows loading screen
    return loading ? Loading() : Scaffold(
      body: SingleChildScrollView(
          child: Stack(
            overflow: Overflow.visible,// overflow: Overflow.clip,
            children: <Widget>[
              Image.asset(
                'assets/login-screen-img.jpg',
                // height: height + 10,
                // width: 500,
                alignment: Alignment.topCenter,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 220.0, 16.0, 0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                    child: Form(
                      //associating global key with the form(It keeps track of the form)
                      key: _formKey, 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Email', style: TextStyle(fontSize: 14.0, color: Colors.grey),),
                          TextFormField(      // email field
                            cursorColor: Colors.brown[500],
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown[500])
                              ),
                              //hintText: 'Enter your Email'
                            ),
                            // validation
                            validator: (email) => email.isEmpty ? 'Enter the email' : null,
                            onChanged: (emailInput) {
                              setState(() {
                                email = emailInput;
                              });
                            },
                          ),
                          SizedBox(height: 16.0),
                          Text('Password', style: TextStyle(fontSize: 14.0, color: Colors.grey),),
                          TextFormField(      // password field
                            cursorColor: Colors.brown[500],
                            decoration: InputDecoration(
                              //hintText: 'Enter your Password'
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.brown[500])
                              )
                            ),
                            // validation
                            validator: (password) => password.length < 6 ? 'Password must be more than 6 characters' : null,
                            obscureText: true, // hide when type
                            onChanged: (passwordInput) {
                              setState(() {
                                password = passwordInput;
                              });
                            },
                          ),
                          SizedBox(height: 48.0,),
                          Center(
                            child: RaisedButton(  // login button
                              child: Text('LOG IN', style: TextStyle(fontSize: 16.0, color: Colors.white),),
                              color: Colors.brown[500],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                              ),
                              padding: EdgeInsets.fromLTRB(66.0, 16.0, 66.0, 16.0),
                              onPressed: () async {
                                if(_formKey.currentState.validate()) { // check validation
                                  // show loading screen
                                  setState(() {
                                    loading = true;
                                  });
                
                                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                
                                  if(result == null) {
                                    // stop showing loading screen/widget
                                    setState(() {
                                      loading = false;
                                    });
                
                                    // show an error message
                                    Fluttertoast.showToast(
                                      msg: 'Could not sign in!',
                                      toastLength: Toast.LENGTH_SHORT,
                                    );
                
                                  }
                                  
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Center(child: Text('Don\'t have and account ?' )),
                          SizedBox(height: 16.0,),
                          Center(
                            child: FlatButton(   // sign up button
                              child: Text('SIGN UP', style: TextStyle(fontSize: 16.0, color: Colors.brown[500] )),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => SignUp()
                                ));
                              }, 
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}