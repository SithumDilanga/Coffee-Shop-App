import 'package:flutter/material.dart';

class StatusCard {

  final onTheWayCard  = Card(
    color: Colors.green[700],
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
      child: Text(
        'on the way',
        style: TextStyle(
          fontSize: 10,
          color: Colors.white
        ),
      ),
    ),
  );


  final orderFinishedCard  = Card(
    color: Colors.yellow,
    child: Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 3.0, 5.0, 3.0),
      child: Text(
        'order finished',
        style: TextStyle(
          fontSize: 10,
          color: Colors.white
        ),
      ),
    ),
  );


}

