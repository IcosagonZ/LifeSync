import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../data/backend.dart';

import '../components/snackbar_notify.dart';
import '../components/dialog_information.dart';

class Page_Chat extends StatefulWidget
{
  const Page_Chat({super.key});

  @override
  State<Page_Chat> createState() => Page_Chat_State();
}

class Page_Chat_State extends State<Page_Chat>
{
  List<List<String>> messages = [];

  TextEditingController message_controller = TextEditingController();

  Future<LLMResponse> sendData() async
  {
    final user_message = message_controller.text;
    final server_response = await backend_send_llm(user_message);

    if(server_response.status=="OK")
    {
      setState(()
      {
        message_controller.text = "";
        messages.add([user_message, server_response.message]);
      });

      return server_response;
    }
    else
    {
      setState(()
      {
        messages.add([user_message, "Server error"]);
      });
      return server_response;
    }
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

    // Widget size variables

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat with AI"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index_reverse){
            final index = messages.length - index_reverse - 1;
            return Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(16),
                      child: Text(messages[index][0])
                    )
                  )
                ),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(16),
                      child: Text(messages[index][1])
                    )
                  )
                ),
                SizedBox(height: 32),
              ],
            );
          },
        )
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextField(
                  controller: message_controller,
                  decoration: InputDecoration(
                    labelText: "Message",
                    hintText: "Enter message",
                  )
                )
              ),
              SizedBox(width: 16),
              IconButton(
                icon: Icon(Symbols.send),
                tooltip: "Send message",
                onPressed: () async
                {
                  final response = await sendData();
                  if(response.status!="OK")
                  {
                    dialog_information_show(context, "Error: ${response.status}", response.message);
                  }
                },
              )
            ],
          ),
        )
      ),
    );
  }
}
