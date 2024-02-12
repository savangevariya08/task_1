import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String btnName;
  final Icon? icon;
  final Color? bgcolor;
  final VoidCallback? callback;

  RoundedButton(
      {required this.btnName, this.icon, this.bgcolor=Colors.blue, this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          callback!();
        },
        child:icon!=null? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon!,
            Container(width: 11,),
            Text(btnName)
          ],
        ):Text(btnName),
        style:ElevatedButton.styleFrom(
          primary: bgcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(21),
              bottomLeft: Radius.circular(21),
            )
          )
        ) ,
    );
  }
}
