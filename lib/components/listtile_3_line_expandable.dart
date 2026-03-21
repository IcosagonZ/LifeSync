import 'package:flutter/material.dart';

class ListTile3LineExpandable extends StatelessWidget
{
  //final Icon list_icon;
  final String list_title;
  final String list_subtitle;
  final String list_description;

  const ListTile3LineExpandable({
    Key? key,
    //required this.list_icon,
    required this.list_title,
    required this.list_subtitle,
    required this.list_description
  }) : super (key: key);

  @override
  Widget build(BuildContext context)
  {
    // Theming and text styles
    final color_scheme = Theme.of(context).colorScheme;
    final text_theme = Theme.of(context).textTheme;

    Color color_primary = color_scheme.primary;
    Color color_secondary = color_scheme.secondary;
    Color color_onprimary = color_scheme.onPrimary;
    Color color_onsecondary = color_scheme.onSecondary;
    Color color_background = color_scheme.onBackground;
    Color color_surface = color_scheme.onSurface;

    final style_displaylarge = text_theme.displayLarge;
    final style_displaymedium = text_theme.displayMedium;
    final style_displaysmall = text_theme.displaySmall;

    final style_headlinelarge = text_theme.headlineLarge;
    final style_headlinemedium = text_theme.headlineMedium;
    final style_headlinesmall = text_theme.headlineSmall;

    final style_titlelarge = text_theme.titleLarge;
    final style_titlemedium = text_theme.titleMedium;
    final style_titlesmall = text_theme.titleSmall;


    return ExpansionTile(
      title: Text(list_title, textAlign: TextAlign.left),
      subtitle: Text(list_subtitle, textAlign: TextAlign.left),
      shape: Border(),
      children: [
        Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Text(list_description, textAlign: TextAlign.center)
        ),
      ],
    );
  }
}
