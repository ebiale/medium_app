import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.overflow,
    this.maxLines,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overflow,
        maxLines: maxLines,
        style: TextStyle(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            fontFamily: fontFamily));
  }
}

class CustomWhiteText extends StatelessWidget {
  const CustomWhiteText({super.key, required this.text, this.fontSize});

  final String text;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      color: Colors.white,
      fontSize: fontSize,
    );
  }
}
