import 'package:flutter/cupertino.dart';

class DefaultText extends StatelessWidget {
  const DefaultText({Key? key, required this.text, this.color, this.fontSize, this.fontWeidght}) : super(key: key);
final String text;
final Color? color;
final double? fontSize;
final FontWeight? fontWeidght;
  @override
  Widget build(BuildContext context) {
    return
      Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: fontWeidght,
          fontSize: fontSize,
        ),
      );

  }
}
