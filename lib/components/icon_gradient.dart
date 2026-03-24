import 'package:flutter/material.dart';

Widget IconGradient(IconData icon_data, List<Color> gradient, [double icon_size=16])
{
  return Padding(
    padding: EdgeInsets.all(2),
    child: ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => LinearGradient(
        begin: AlignmentGeometry.topLeft,
        end:AlignmentGeometry.bottomRight,
        colors: gradient,
      ).createShader(bounds),
      child: Icon(icon_data, fill: 1, size: icon_size)
    ),
  );
}
