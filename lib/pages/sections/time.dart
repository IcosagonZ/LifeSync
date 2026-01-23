import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class Page_Time extends StatefulWidget
{
  const Page_Time({super.key});

  @override
  State<Page_Time> createState() => Page_Time_State();
}

class Page_Time_State extends State<Page_Time>
{
  Container piechart_label(String label_text)
  {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label_text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

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

    Map<String, double> time_breakdown = {
      "Sleep": 0,
      "Study": 3,
      "Eating": 3,
      "Hobby": 2,
      "Gaming": 2,
      "Outing": 1,
      "Commute": 1,
      "Entertainment": 3,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text("Time"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: PieChart(
                  PieChartData(
                    sections: [
                      // Sleep
                      PieChartSectionData(
                        color: color_primary,
                        value: time_breakdown["Sleep"],
                        title: "",
                        badgeWidget: (time_breakdown["Sleep"] ?? 0.0) > 0.01 ?
                        Icon(Symbols.bedtime, color:color_onprimary)
                        : null,
                      ),
                      // Study
                      PieChartSectionData(
                        color: color_primary,
                        value: time_breakdown["Study"],
                        title: "",
                        badgeWidget: (time_breakdown["Study"] ?? 0.0) > 0.01 ?
                        Icon(Symbols.book, color:color_onprimary)
                        : null,
                      ),
                      // Food
                      PieChartSectionData(
                        color: color_primary,
                        value: time_breakdown["Eating"],
                        title: "",
                        badgeWidget: (time_breakdown["Eating"] ?? 0.0) > 0.01 ?
                        Icon(Symbols.flatware, color:color_onprimary)
                        : null,
                      ),
                      // Hobby
                      PieChartSectionData(
                        color: color_primary,
                        value: time_breakdown["Hobby"],
                        title: "",
                        badgeWidget: (time_breakdown["Hobby"] ?? 0.0) > 0.01 ?
                        Icon(Symbols.construction, color:color_onprimary)
                        : null,
                      ),
                      // Gaming
                      PieChartSectionData(
                        color: color_primary,
                        value: time_breakdown["Gaming"],
                        title: "",
                        badgeWidget: (time_breakdown["Gaming"] ?? 0.0) > 0.01 ?
                        Icon(Symbols.sports_esports, color:color_onprimary)
                        : null,
                      ),
                      // Outing
                      PieChartSectionData(
                        color: color_primary,
                        value: time_breakdown["Outing"],
                        title: "",
                        badgeWidget: (time_breakdown["Outing"] ?? 0.0) > 0.01 ?
                        Icon(Symbols.tour, color:color_onprimary)
                        : null,
                      ),
                      // Commute
                      PieChartSectionData(
                        color: color_primary,
                        value: time_breakdown["Commute"],
                        title: "",
                        badgeWidget: (time_breakdown["Commute"] ?? 0.0) > 0.01 ?
                        Icon(Symbols.commute, color:color_onprimary)
                        : null,
                      ),
                      // Entertainment
                      PieChartSectionData(
                        color: color_primary,
                        value: time_breakdown["Entertainment"],
                        title: "",
                        badgeWidget: (time_breakdown["Entertainment"] ?? 0.0) > 0.01 ?
                        Icon(Symbols.comedy_mask, color:color_onprimary)
                        : null,
                      ),
                    ]
                  )
                )
              )
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Symbols.bedtime, color: color_primary),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Sleep", style: TextStyle(color: color_primary))
                        ),
                        SizedBox(width: 8),
                        Text("${time_breakdown["Sleep"]} hrs")
                      ]
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Symbols.book, color: color_primary),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Study", style: TextStyle(color: color_primary))
                        ),
                        SizedBox(width: 8),
                        Text("${time_breakdown["Study"]} hrs")
                      ]
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Symbols.flatware, color: color_primary),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Eating", style: TextStyle(color: color_primary))
                        ),
                        SizedBox(width: 8),
                        Text("${time_breakdown["Eating"]} hrs")
                      ]
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Symbols.construction, color: color_primary),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Hobby", style: TextStyle(color: color_primary))
                        ),
                        SizedBox(width: 8),
                        Text("${time_breakdown["Hobby"]} hrs")
                      ]
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Symbols.sports_esports, color: color_primary),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Gaming", style: TextStyle(color: color_primary))
                        ),
                        SizedBox(width: 8),
                        Text("${time_breakdown["Gaming"]} hrs")
                      ]
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Symbols.tour, color: color_primary),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Outing", style: TextStyle(color: color_primary))
                        ),
                        SizedBox(width: 8),
                        Text("${time_breakdown["Outing"]} hrs")
                      ]
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Symbols.commute, color: color_primary),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Commute", style: TextStyle(color: color_primary))
                        ),
                        SizedBox(width: 8),
                        Text("${time_breakdown["Commute"]} hrs")
                      ]
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Symbols.comedy_mask, color: color_primary),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Entertainment", style: TextStyle(color: color_primary))
                        ),
                        SizedBox(width: 8),
                        Text("${time_breakdown["Entertainment"]} hrs")
                      ]
                    ),
                  ]
                )
              )
            )
          ]
        )
      ),
    );
  }
}
