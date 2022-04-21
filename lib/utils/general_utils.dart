import 'package:flutter/material.dart';

class GeneralUtils{


  List<String> _contractionTrades = ['bricks','plaster','ceiling'];
  List<String> _furnitureTrades = ['doors'];

  Color getTradeColor(String trade){
    if(_contractionTrades.contains(trade)){return Colors.blue;}
    else if(_furnitureTrades.contains(trade)){return Colors.red;}
    else{
      print('[-] Color not found for the trade $trade');
      return Colors.black;
    }
  }


}