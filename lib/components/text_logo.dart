import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mask_gradient.dart';

Widget TextLogo(String text, List<Color> gradient, double fontSize)
{
  return MaskGradient(
    Text(
      text,
      style: GoogleFonts.asimovian().copyWith(
        color: gradient.first,
        fontSize: fontSize
      )
    ),
    gradient
  );
}
