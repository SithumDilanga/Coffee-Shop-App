import 'package:flutter/material.dart';

class TodaySpecialItem extends StatefulWidget {
  @override
  _TodaySpecialItemState createState() => _TodaySpecialItemState();
}

class _TodaySpecialItemState extends State<TodaySpecialItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              Image.asset('assets/home-img.png'),
              SizedBox(height: 8.0),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('Cappucino', style: TextStyle(fontSize: 16.0),),
                ),
              ),
              SizedBox(height: 4.0),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('lorem ipusum lorem', style: TextStyle(fontSize: 11.0, color: Colors.grey)),
                ),
              ),
              SizedBox(height: 4.0),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text('230 LKR', style: TextStyle(fontSize: 16.0, color: Colors.brown[500])),
                ),
              ),
            ]
          ),
        );
  }
}