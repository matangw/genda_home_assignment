import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconsUtils{


  // widget to use when wanting an svg image as widget
  Widget SvgIcon({
   required String path,
    Color? color,
    double? width,
    double? height,
    String? semanticLabel
  })  {
    return SvgPicture.asset(
        path,
        color: color?? Colors.blueGrey,
        height: height?? 10,
        width: width?? 10,
        semanticsLabel:  semanticLabel,
    );
  }


  // function with input of certain trade that will return the icon path for it
  String pathIconForTrade(String trade){
      if(trade == 'bricks') {return 'icons/worconsBricksTl3.svg'; }
      else if(trade == 'ceiling') {return 'icons/worconsCleaningTl3.svg'; }
      else if(trade == 'doors'){return 'icons/worconsDoorsTl3.svg';}
      else if(trade == 'plaster'){return 'icons/worconsPlasterTl3.svg';}
      else
        {return '[-] no icon found';}

  }



}