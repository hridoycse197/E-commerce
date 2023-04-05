import 'package:flutter/material.dart';

class Ktext extends StatelessWidget {
  final String? text;
  final Color? fontColor;
  final double? fontSize;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  TextOverflow textOverflow;
  final int? maxLines;
  final bool? bold;

  Ktext({this.textDecoration=TextDecoration.none,
    required this.text,
    this.fontColor,
    this.bold = false,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.textOverflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      textScaleFactor: 1.0,
      style: TextStyle(
        decoration: textDecoration,
        fontSize: fontSize != null ? fontSize! : 14,
        fontFamily: bold! ? 'Manrope Bold' : 'Manrope Regular',
        color: fontColor ?? Colors.black,
      ),
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
