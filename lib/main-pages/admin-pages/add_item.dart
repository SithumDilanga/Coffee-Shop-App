import 'dart:io';
import 'package:coffee_shop_app/services/database.dart';
import 'package:coffee_shop_app/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  String dropdownValue = 'Coffee';
  final itemNameController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemDescController = TextEditingController();

  DataBaseService database = DataBaseService();
  Storage storage = Storage();

  // ------- product image pick -------

  File _image;
  final picker = ImagePicker();

  Future pickImage() async {
    
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
    
    // calling uploadProductImage
    storage.uploadProductImage(_image);

  }

  // ------- End product image pick ------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        backgroundColor: Colors.brown,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 16.0),
                  child: Column(
                    children: <Widget> [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          Container(
                            // color: Colors.yellow,
                            width: 100,
                            child: Text(
                              'Category',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          //SizedBox(width: 24.0),
                          Container(
                            padding: EdgeInsets.only(left: 8.0, right: 8.0),
                            height: 55,
                            width: 140,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey
                              ),
                              borderRadius: BorderRadius.circular(2.0)
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                icon: Icon(Icons.expand_more),
                                iconSize: 24,
                                elevation: 3,
                                isDense: true,
                                isExpanded: true,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black,
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Colors.brown[900],
                                ),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>['Coffee', 'Snacks', 'Desserts'].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }
                              ).toList(),
                              ),
                            ),
                          ),
                        ]
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: <Widget> [
                            Container(
                              // color: Colors.yellow,
                              width: 100,
                              child: Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            //SizedBox(width: 55.0), //TODO: find a way to align all input text fields
                            Expanded(
                              child: Container(
                                height: 55.0,
                                child: TextFormField(
                                  controller: itemNameController,
                                  style: TextStyle(
                                    fontSize: 16.0
                                  ),
                                  cursorColor: Colors.brown[500],
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey[800]),
                                      borderRadius: BorderRadius.circular(2)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey[500]),
                                      borderRadius: BorderRadius.circular(2)
                                    )
                                  ),
                                ),
                              ),
                            )
                          ]
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: <Widget> [
                            Container(
                              // color: Colors.yellow,
                              width: 100,
                              child: Text(
                                'Price',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                //color: Colors.yellow,
                                height: 55.0,
                                child: TextFormField(
                                  controller: itemPriceController,
                                  // maxLines: null,
                                  // minLines: null,
                                  // expands: true,
                                  style: TextStyle(
                                    fontSize: 16.0
                                  ),
                                  cursorColor: Colors.brown[500],
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey[800]),
                                      borderRadius: BorderRadius.circular(2)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey[500]),
                                      borderRadius: BorderRadius.circular(2)
                                    )
                                  ),
                                ),
                              ),
                            )
                          ]
                        ),
                      ),
                      SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                // color: Colors.yellow,
                                width: 100,
                                child: Text(
                                  'Desc',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 130.0,
                                child: TextFormField(
                                  controller: itemDescController,
                                  // keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  style: TextStyle(
                                    fontSize: 16.0
                                  ),
                                  cursorColor: Colors.brown[500],
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey[800]),
                                      borderRadius: BorderRadius.circular(2)
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey[500]),
                                      borderRadius: BorderRadius.circular(2)
                                    )
                                  ),
                                ),
                              ),
                            )
                          ]
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Row(
                          children: <Widget> [
                            Container(
                              // color: Colors.yellow,
                              width: 100,
                              child: Text(
                                'Image',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                // padding: EdgeInsets.only(right: 64.0,),
                                height: 40.0,
                                child: InkWell(
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Icon(
                                          Icons.upload_rounded,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        'Pick a Image',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey
                                        ),
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    pickImage();
                                  },
                                )
                              ),
                            )
                          ]
                        ),
                      ),
                      SizedBox(height: 40.0),
                      RaisedButton(
                        padding: EdgeInsets.only(top: 14.0, bottom: 14.0, left: 72.0, right:72.0),
                        color: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0)
                        ),
                        child: Text(  
                          'ADD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        onPressed: () {

                          if(dropdownValue == 'Coffee') {
                            // add data to coffee collection
                            database.updateProductData(
                              dropdownValue, 
                              itemNameController.text, 
                              double.parse(itemPriceController.text), 
                              itemDescController.text,
                              storage.imageLink
                            );

                          } else if(dropdownValue == 'Snacks') {
                            // add data to snacks collection
                          } else {
                            // add data to desserts collection
                          }

                        }
                      ),
                    ]
                  ),
                )
              ),
            ),
          ),
        );
        } 
      ),
    );
  }
}