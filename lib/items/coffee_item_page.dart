import 'package:coffee_shop_app/common/lock_cart_user.dart';
import 'package:coffee_shop_app/models/cart.dart';
import 'package:coffee_shop_app/models/item.dart';
import 'package:coffee_shop_app/models/product.dart';
import 'package:coffee_shop_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:coffee_shop_app/icons/my_icons.dart';
import 'package:provider/provider.dart';

class CoffeeItem extends StatefulWidget{

  final Product product;

  CoffeeItem({this.product});

  @override
  _CoffeeItemState createState() => _CoffeeItemState();
}

class _CoffeeItemState extends State<CoffeeItem> {

  String itemName = 'Cappuccino';
  double itemPrice = 240.00;
  int tableNo;
  int itemCount = 1;
  final tableNoController = TextEditingController();
  
  String errorMsg;

  // static bool once = false;

  @override
  Widget build(BuildContext context) { 

    // var item = Provider.of<Item>(context);

    // Cart Provider
    var cart = Provider.of<Cart>(context);

    return Material(
      child: Stack(
        children: <Widget>[
          Image.network(
            '${widget.product.imgUrl}',
            fit: BoxFit.cover,
            height: 280,
            width: double.infinity,
          ),// item image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget> [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: IconButton(         // back button
                      icon: Icon(Icons.arrow_back, size: 30,),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                SizedBox(height: 120),
                Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget> [
                      //----------- item title -----------
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            Text(
                              '${widget.product.name}', 
                              style: TextStyle(
                                fontSize: 24.0, 
                                fontWeight: FontWeight.w700
                              ),
                            ),

                            Text(
                              '${widget.product.price} LKR',
                              style: TextStyle(
                                fontSize: 24.0, 
                                fontWeight: FontWeight.w700, 
                                color: HexColor('#5D2300')
                              ),
                            ),
                          ]
                        ),
                      ),
                      //----------- End item title -----------

                      //--------- item description ----------
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Text(
                            '${widget.product.desc}', 
                            style: TextStyle(
                              fontSize: 14.0, 
                              color: Colors.grey
                            ),
                          ),
                        ),
                      ),
                      //--------- End item description ----------
                      SizedBox(height: 8.0),
                      //----------- item amount ----------
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(MyIcons.minuIcon, size: 34.0, color: Colors.brown,),
                              onPressed: () {
                                //item.decrease();
                                setState(() {
                                  itemCount--;
                                  print(itemCount);
                                });
                              },
                            ),
                            SizedBox(width: 8.0),
                            Text('${itemCount}',style: TextStyle(fontSize: 16.0),),
                            SizedBox(width: 8.0),
                            IconButton(
                              icon: Icon(MyIcons.plusIcon, size: 34.0, color: Colors.brown,),
                              onPressed: () {
                                setState(() {
                                  itemCount++;
                                  print(itemCount);
                                });
                                //item.increase(itemCount);
                              },
                            ),
                          ]
                        ),
                      ),
                      //----------- End item amount ----------
                      SizedBox(height:24.0),
                      //---------- table no input ----------
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 48.0,),
                        child: Row(
                          children: <Widget> [
                            Text('Table No: ', style: TextStyle(fontSize: 16.0),),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: Container(
                                height: 30.0,
                                child: TextFormField(  
                                  controller: tableNoController,    // email field
                                  cursorColor: Colors.brown[500],
                                  decoration: InputDecoration(
                                    //contentPadding: EdgeInsets.only(top: 1.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.brown[500],)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.brown[300], ),
                                    ),
                                  //hintText: 'Enter your Email'
                                  ),
                                  // validation
                                  validator: (tableNo) {
                                    return errorMsg = tableNo.isEmpty ? 'Enter table No:' : null;
                                    
                                  },
                                  //onChanged: (tableNum) { },
                                style: TextStyle(fontSize: 16.0),
                              ),
                              ),
                            ), 
                          ]
                        ),
                      ),
                      //---------- End table no input ----------
                      SizedBox(height: 24.0),
                      // ---------- Buttons ----------
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget> [
                            RaisedButton(
                              color: Colors.brown,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 14.0),
                                child: Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 16.0),),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0)
                              ),
                              onPressed: () {

                                print(tableNoController.text);
                                if(tableNoController.text == '') {
                                  Fluttertoast.showToast(
                                    msg: 'Please Enter Table Number!',
                                    toastLength: Toast.LENGTH_SHORT,
                                  );
                                } else {

                                  // TODO: check tableNoController data type

                                  // calling add to cart method
                                  cart.addToCart(
                                    Item(
                                      itemName:widget.product.name, 
                                      itemPrice: widget.product.price, 
                                      itemImage: widget.product.imgUrl,
                                      amount: itemCount, 
                                      tableNo: tableNoController.text
                                    )
                                  );
                                  
                                  // add current item price to total
                                  cart.addPriceToTotal(widget.product.price * itemCount);

                                  Fluttertoast.showToast(
                                    msg: 'Added to Cart',
                                    toastLength: Toast.LENGTH_SHORT,
                                  );

                                  if(LockCartUser.once == false) {
                                    DataBaseService().currentCartUser();
                                    LockCartUser.once = true;
                                  }

                                } 
                              },
                            ),
                            RaisedButton(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 14.0),
                                child: Text('Order Now', style: TextStyle(color: Colors.brown, fontSize: 16.0), ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35.0),
                                side: BorderSide(color: Colors.brown)
                              ),
                              onPressed: () {},
                            ),
                          ]
                        ),
                      ),
                      // ---------- End Buttons ----------
                    ] 
                  ),
                )
              ]
            ),
          ),          
        ],
      ),
    );
    
    /*MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,//HexColor('#FFFFFF'),
        body: SingleChildScrollView(
          //physics: AlwaysScrollableScrollPhysics(),
          child: Container(
              //constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/cappuccino.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topLeft,
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 32.0),
                child: Column(
                  children:<Widget> [
                    Row(
                      children:<Widget> [
                        IconButton(
                          icon: Icon(Icons.arrow_back, size: 30,), 
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          }
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          'Coffee',
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
                    SizedBox(height: 50.0),
                    Card(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('data')
                            ],
                          ),
                        ],
                      )
                    )
                  ],
                ),
              )
            ),
        ),
      )
    );*/
    
    /*MaterialApp(
      home: Scaffold(
        body:SingleChildScrollView(
          child: Container(
                //constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/cappuccino.jpg'),
                    fit: BoxFit.contain,
                    alignment: Alignment.topLeft,
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: <Widget> [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      SizedBox(height: 100),
                      Card(
                        child: Column(
                          children: <Widget> [
                            Row(
                              children: <Widget> [
                                Text('data'),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Text('data')
                                ),
                              ]
                            ),
                          ] 
                        ),
                      )
                    ]
                  ),
                ),
              ),
        ),
      ),
    );*/
  }
}