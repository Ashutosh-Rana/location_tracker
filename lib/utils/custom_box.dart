import 'package:flutter/material.dart';

class CustomSizedBox extends StatelessWidget {
  final double height;

  CustomSizedBox({required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}