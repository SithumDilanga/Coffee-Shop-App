import 'package:coffee_shop_app/common/isAddedToCart.dart';
import 'package:coffee_shop_app/models/cart.dart';
import 'package:coffee_shop_app/models/item.dart';
import 'package:coffee_shop_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:coffee_shop_app/icons/my_icons.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget{

  final Product product;

  ProductItem({this.product});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  String itemName = 'Cappuccino';
  int itemPrice = 240;
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
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/home-bg.jpg'),
              colorFilter: ColorFilter.mode(
                Colors.white24,
                BlendMode.modulate
              ),
              fit: BoxFit.cover,
              // alignment: Alignment.topLeft,
            )
          ),
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
                              Expanded(
                                // flex: 4,
                                child: Text(   // product name
                                  '${widget.product.name}', 
                                  style: TextStyle(
                                    fontSize: 24.0, 
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                            
                              Text(  // Price
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
                                    if(itemCount < 1) { // should not below 0
                                      itemCount = 1;
                                    }
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
                                    controller: tableNoController,
                                    cursorColor: Colors.brown[500],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 0.8, left: 8.0),
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
                            
                                  } 
                                  
                                  setState(() {
                                    IsAddedToCart.isAddedToCart = true;
                                    print('da hell ' + IsAddedToCart.isAddedToCart.toString());
                                  });
                            
                            
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
      ),
    );
  }
}