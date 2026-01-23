import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class RecentsListTile extends StatelessWidget
{
  final Icon list_icon;
  final String list_title;
  final String list_subtitle;
  final DateTime list_date;

  const RecentsListTile({
    Key? key,
    required this.list_icon,
    required this.list_title,
    required this.list_subtitle,
    required this.list_date,
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


    return Card(
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            list_icon,
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(list_title, textAlign: TextAlign.left, style: style_titlemedium),
            ),
            Text(list_subtitle),
            SizedBox(
              width: 16,
            ),
            Text(DateFormat('dd/M/yy').format(list_date)),
            SizedBox(
              width: 8,
            ),
            Text(DateFormat('h:mm a').format(list_date)),
            PopupMenuButton(
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                PopupMenuItem(
                  child: Text("View"),
                  onTap: (){
                    print("View tapped");
                  },
                ),
                PopupMenuItem(
                  child: Text("Edit"),
                  onTap: (){
                    print("Edit tapped");
                  },
                ),
                PopupMenuItem(
                  child: Text("Remove"),
                  onTap: (){
                    print("Remove tapped");
                  },
                ),
              ],
            )
          ]
        )
      )
      /*
       *      child: ListTile(
       *        leading: list_icon,
       *        title: Text(list_title),
       *        subtitle: Text(list_subtitle),
       *        trailing:
    ),
    */
    );
  }
}
