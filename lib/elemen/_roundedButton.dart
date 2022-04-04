import 'package:flutter/material.dart';
import 'package:njawani/constant.dart';

class RoundedButton extends StatelessWidget {
  final Widget child;
  final void Function() press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.child,
    required this.press,
    this.color = prblue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton() {
    return ElevatedButton(
      child: child,
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
