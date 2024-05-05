import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget poppinsTxt(
    {required String txt,
    double? txtSize,
    FontWeight? txtWeight,
    Color? clr,
    Function()? poppinFunc}) {
  return InkWell(
    onTap: poppinFunc,
    child: Text(
      txt,
      style: GoogleFonts.poppins(
        fontSize: txtSize,
        fontWeight: txtWeight ?? FontWeight.w300,
        color: clr,
      ),
    ),
  );
}

Widget dmSansTxt(
    {required String txt,
    double? txtSize,
    FontWeight? txtWeight,
    Color? clr,
    TextDecoration? txtDecor,
    Color? clrDecor,
    Function()? dmFunc}) {
  return InkWell(
    onTap: dmFunc,
    child: Text(
      txt,
      style: GoogleFonts.dmSans(
        decoration: txtDecor,
        decorationColor: clrDecor,
        fontSize: txtSize,
        fontWeight: txtWeight ?? FontWeight.w300,
        color: clr,
      ),
    ),
  );
}
