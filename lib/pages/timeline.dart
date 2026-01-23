import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../components/timeline_listtile.dart';

import '../data/database.dart';

class Page_Timeline extends StatefulWidget
{
  const Page_Timeline({super.key});

  @override
  State<Page_Timeline> createState() => Page_Timeline_State();
}

class Page_Timeline_State extends State<Page_Timeline>
{

  @override
  Widget build(BuildContext context)
  {
    // Widget styles and variables
    // Theming and text styles
    final text_theme = Theme.of(context).textTheme;

    final style_displaylarge = text_theme.displayLarge;
    final style_displaymedium = text_theme.displayMedium;
    final style_displaysmall = text_theme.displaySmall;

    final style_headlinelarge = text_theme.headlineLarge;
    final style_headlinemedium = text_theme.headlineMedium;
    final style_headlinesmall = text_theme.headlineSmall;

    final style_titlelarge = text_theme.titleLarge;
    final style_titlemedium = text_theme.titleMedium;
    final style_titlesmall = text_theme.titleSmall;

    List<String> list_common_dates = [];
    List<String> list_common_months = [];
    List<String> list_common_years = [];

    List<TimelineData> timeline_data = get_timeline_data();

    return Scaffold(
      appBar: AppBar(
        title: Text("Timeline"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Stack(
          children: [
            Visibility(
              visible: timeline_data.isNotEmpty,
              child: ListView(
                children: timeline_data.map((data)
                {
                  String data_date_string = DateFormat('d/M/yyyy').format(data.item_datetime);
                  String data_month_string = DateFormat('M/yyyy').format(data.item_datetime);
                  String data_year_string = DateFormat('yyyy').format(data.item_datetime);

                  TimelineListTile data_tile = TimelineListTile(
                    list_icon: Icon(data.item_icon),
                    list_title: data.item_title,
                    list_subtitle: data.item_subtitle,
                    list_date: data.item_datetime,
                  );

                  // If other tile in day exist
                  if(list_common_dates.contains(data_date_string))
                  {
                    return Column(
                      children: [
                        data_tile,
                        SizedBox(
                          height: 8
                        ),
                      ],
                    );
                  }
                  // If other tile in year and month exist but not day
                  else if(list_common_months.contains(data_month_string))
                  {
                    list_common_dates.insert(0, data_date_string);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        SizedBox(
                          height: 8
                        ),
                        // Date display
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(DateFormat('MMMM, d').format(data.item_datetime), style:style_titlemedium),
                          ]
                        ),
                        data_tile,
                        SizedBox(
                          height: 8
                        ),
                      ]
                    );
                  }
                  // If other tile in year exist but not day and month
                  else if(list_common_years.contains(data_year_string))
                  {
                    list_common_months.insert(0, data_month_string);
                    list_common_dates.insert(0, data_date_string);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        SizedBox(
                          height: 8
                        ),
                        // Month display
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(DateFormat('MMMM').format(data.item_datetime), style:style_titlemedium),
                          ]
                        ),
                        SizedBox(
                          height: 8
                        ),
                        // Date display
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(DateFormat('MMMM, d').format(data.item_datetime), style:style_titlemedium),
                          ]
                        ),
                        data_tile,
                        SizedBox(
                          height: 8
                        ),
                      ]
                    );
                  }
                  // If other tile in year, month and day doesnt exist
                  else
                  {
                    list_common_dates.insert(0, data_date_string);
                    list_common_months.insert(0, data_month_string);
                    list_common_years.insert(0, data_year_string);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        SizedBox(
                          height: 8
                        ),
                        // Year display
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                              child: Divider()
                            ),
                            Text(DateFormat('yyyy').format(data.item_datetime), style:style_headlinemedium),
                            Expanded(
                              child: Divider()
                            ),
                          ]
                        ),
                        SizedBox(
                          height: 8
                        ),
                        // Month display
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(DateFormat('MMMM').format(data.item_datetime), style:style_headlinesmall),
                          ]
                        ),
                        SizedBox(
                          height: 16
                        ),
                        // Date display
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                            ),
                            Text(DateFormat('MMMM, d').format(data.item_datetime), style:style_titlemedium),
                          ]
                        ),
                        data_tile,
                        SizedBox(
                          height: 8
                        ),
                      ]
                    );
                  }
                }).toList(),
              )
            ),
            Visibility(
              visible: timeline_data.isEmpty,
              child: Center(
                child: Text("No data")
              )
            )
          ]
        )
      ),
    );
  }
}
