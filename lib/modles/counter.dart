import 'package:flutter/material.dart';

class Counter
 {
   Counter( 
      {
       this.id,
       this.count,
      required this.title,
      required this.color
        });
  var id;
  var count;
  final String title;
  final Color color;
}
