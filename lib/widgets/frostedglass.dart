import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox(
      {Key? key,
      required this.theWidth,
      required this.theHeight,
      required this.theChild})
      : super(key: key);

  final theWidth;
  final theHeight;
  final theChild;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: theWidth,
        height: theHeight,
        color: Colors.white,
        child: Stack(
          children: [
            //blur effect
            BackdropFilter(
                filter: ImageFilter.blur(
              sigmaX: 4.0,
              sigmaY: 4.0,
            ))
          ],
        ),
      ),
    );
  }
}
