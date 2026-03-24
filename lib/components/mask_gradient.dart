import 'package:flutter/material.dart';

Widget MaskGradient(Widget child, List<Color> gradient)
{
  return ShaderMask(
    blendMode: BlendMode.srcIn,
    shaderCallback: (Rect bounds) => LinearGradient(
      begin: AlignmentGeometry.topLeft,
      end:AlignmentGeometry.bottomRight,
      colors: gradient,
    ).createShader(bounds),
    child: child,
  );
}
