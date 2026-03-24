import 'package:flutter/material.dart';

Widget AvatarGradient(String avatar_value, String avatar_heading, List<Color> gradient)
{
  return Stack(
    alignment: Alignment.center,
    children: [
      ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) => LinearGradient(
          begin: AlignmentGeometry.topLeft,
          end:AlignmentGeometry.bottomRight,
          colors: gradient,
        ).createShader(bounds),
        child: CircleAvatar(
          radius: 32,
          backgroundColor: gradient.first,
        )
      ),
      Column(
        children: [
          Text(avatar_value, style: TextStyle(color: Colors.white)),
          Text(avatar_heading, style: TextStyle(fontSize: 10, color: Colors.white)),
        ]
      )
    ]
  );
}
