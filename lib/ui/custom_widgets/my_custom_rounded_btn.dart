import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyCustomRoundedBtn extends StatelessWidget {
  VoidCallback onTap;
  double mWidth;
  double mHeight;
  Color  bgcolor;
  String text;
  Color textColor;
  Icon? mIcon;


  MyCustomRoundedBtn({
    required this.onTap,
    required this.text,
    this.textColor=Colors.black,
    this.mIcon,
    this.mWidth=300,
    this.mHeight=50,
    this.bgcolor=Colors.white, required Color bgColor
  });



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: mWidth,
        height: mHeight,
        child: mIcon!= null ? Row(
          children: [
            mIcon!,
            Expanded(child: Center(child:Text(text, style: TextStyle(fontWeight: FontWeight.bold ),)))
          ],
        ) : Center(
          child: Text(text),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: bgcolor,
        ),
      ),
    );
  }
}
