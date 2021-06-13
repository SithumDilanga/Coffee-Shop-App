import 'package:coffee_shop_app/authenticate/login.dart';
import 'package:coffee_shop_app/common/loading.dart';
import 'package:coffee_shop_app/home/home.dart';
import 'package:coffee_shop_app/services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {

  // to switch between login and sign up
  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  // instance of AutheService class to geth sign up function
  final AuthService _auth = AuthService();

  // to identify the form
  final _formKey = GlobalKey<FormState>();

  // text fields
  String name = '';
  String email = '';
  String password = '';
  String errorMsg = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : 
    Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              Image.asset(
                'assets/sign-up-img.jpg'
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 32.0, 0, 0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 32.0,), 
                  onPressed: () {
                    Navigator.pop(context);
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 220.0, 16.0, 0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('Email', style: TextStyle(fontSize: 14.0, color: Colors.grey),),
                        TextFormField(
                          cursorColor: Colors.brown[500],
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown[500])
                            ),
                            //hintText: 'Enter your Email'
                          ),
                          // validation
                          validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text('Password', style: TextStyle(fontSize: 14.0, color: Colors.grey),),
                        TextFormField(
                          cursorColor: Colors.brown[500],
                          decoration: InputDecoration(
                            //hintText: 'Enter your Password'
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown[500])
                            )
                          ),
                          // validation
                          validator: (val) => val.length < 6 ? 'Enter password 6+ characters long' : null,
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                        ),
                        SizedBox(height: 16.0),
                        Text('Username', style: TextStyle(fontSize: 14.0, color: Colors.grey),),
                        TextFormField(
                          cursorColor: Colors.brown[500],
                          decoration: InputDecoration(
                            //hintText: 'Enter your Name'
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.brown[500])
                            )
                          ),
                          // validation
                          validator: (val) => val.length < 6 ? 'Enter Your Name' : null,
                          onChanged: (val) {
                            setState(() {
                              name = val;
                            });
                          },
                        ),
                        SizedBox(height: 48.0,),
                        Center(
                          child: RaisedButton(
                            child: Text('SIGN UP', style: TextStyle(fontSize: 16.0, color: Colors.white),),
                            color: Colors.brown[500],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)
                            ),
                            padding: EdgeInsets.fromLTRB(66.0, 16.0, 66.0, 16.0),
                            onPressed: () async {
                              // Navigator.push(context, MaterialPageRoute(
                              //   builder: (context) => Login()
                              // ));
                              if(_formKey.currentState.validate()) { //validating the form
      
                                // setting loading to true and show loading screen
                                setState(() => loading = true);
                                
                                // registering a user with email and password
                                dynamic result = await _auth.registerWithEmailAndPassword(name, email, password);
      
                                print('loading variable : ' + loading.toString());
      
                                if(result == null) {
                                  // changing the errorMsg
                                  setState(() {
                                    errorMsg = 'Plaese enter a valid email and password';
                                    //print(errorMsg);
                                    // stop showing loading screen
                                    loading = false;
                                  });
                                } else {
      
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}