import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  String dropdownValue = 'Coffee';
  final itemNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: <Widget> [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget> [
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 24.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        height: 35,
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
                    ),
                  ]
                ),
                SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    children: <Widget> [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: 55.0), //TODO: find a way to align all input text fields
                      Expanded(
                        child: Container(
                          height: 35.0,
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
                )
              ]
            ),
          )
        ),
      ),
    );
  }
}