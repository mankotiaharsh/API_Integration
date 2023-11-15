import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final String headingText;
  final double fontSize;
  const TextWidget(
      {super.key, required this.headingText, required this.fontSize});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.headingText,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: widget.fontSize),
    );
  }
}
