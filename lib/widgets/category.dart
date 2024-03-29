import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:olsis/widgets/constants.dart';

class Category extends StatefulWidget {
  final image;
  final title;
  Category({this.image, this.title});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 17, top: 5),
      child: Column(children: [
        Container(
          height: 70,
          width: 70,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 231, 246, 252),
            boxShadow: [
              BoxShadow(
                offset: Offset(.3, .3),
                color: Colors.black12,
                spreadRadius: .5,
                blurRadius: 1.0,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(child: widget.image),
        ),
        const SizedBox(height: 10),
        Text(
          widget.title,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            textStyle: TextStyle(
              height: 1,
              color: UiConstants.textTitleColor,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ]),
    );
  }
}
