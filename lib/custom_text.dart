// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key,
      this.color,
      this.align,
      this.size,
      required this.text,
      this.weight,
      this.ls,
      this.overflow})
      : super(key: key);
  final String text;
  final bool? weight;
  final double? size;
  final Color? color;
  final TextAlign? align;
  final TextOverflow? overflow;
  final double? ls;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overflow,
        textAlign: align ?? TextAlign.center,
        style: TextStyle(
          fontSize: size ?? 17,
          color: color ?? Colors.black,
          fontWeight: weight ?? false ? FontWeight.bold : FontWeight.normal,
          letterSpacing: ls ?? 0,
        ));
  }
}
