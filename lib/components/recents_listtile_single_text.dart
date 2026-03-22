import 'package:flutter/material.dart';

import '../pages/add_data.dart';

class RecentsListTileSingleText extends StatelessWidget
{
  //final Icon list_icon;
  final String list_title;
  final String list_subtitle;

  final String datatype;
  final int id;

  const RecentsListTileSingleText({
    Key? key,
    //required this.list_icon,
    required this.list_title,
    required this.list_subtitle,

    required this.id,
    required this.datatype,
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


    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(list_title, textAlign: TextAlign.left, style: style_titlemedium),
                  //Text(list_subtitle)
                ]
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Text(list_subtitle),
          ]
        )
      ),
      onTap: (){
        if(id!=-1)
        {
          Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return const Page_AddData();
            },
            settings: RouteSettings(
              arguments: [id, datatype],
            ),
          ));
        }
      },
    );
  }
}
