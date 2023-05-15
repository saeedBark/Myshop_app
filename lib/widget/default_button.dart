import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key,this.color = const Color(0xFFD319C2),this.width = double.infinity,this.radius = 15,
  this.isUpperCase = true,required this.function,required this.text,
  }) : super(key: key);
 final Color color ;
   final   double width ;
 final double radius;
    final  bool isUpperCase ;
  final Function() function;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
      child: MaterialButton(
        onPressed:function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
