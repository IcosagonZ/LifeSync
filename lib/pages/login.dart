import 'package:flutter/material.dart';

import '../data/database.dart';
import '../data/backend.dart';

import '../components/snackbar_notify.dart';
import '../components/dialog_information.dart';
import '../components/text_logo.dart';

import 'overview.dart';

class Page_Login extends StatefulWidget
{
  const Page_Login({super.key});

  @override
  State<Page_Login> createState() => Page_Login_State();
}

class Page_Login_State extends State<Page_Login>
{
  // Controllers
  TextEditingController username_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

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
        title: Text(""),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextLogo(
                "LifeSyncAI",
                [
                  color_primary,
                  color_secondary
                ],
                48
              ),
              SizedBox(height: 32),
              TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Username",
                  hintText: "Enter username",
                ),
                maxLines: null,
              ),
              SizedBox(height: 16),
              TextField(
                controller: password_controller,
                obscureText: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Password",
                  hintText: "Enter password",
                ),
                maxLines: 1,
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text("Login"),
                    onPressed: () async
                    {
                      print("Login pressed");
                      if(username_controller.text.isNotEmpty && password_controller.text.isNotEmpty)
                      {
                        final result = await backend_login(username_controller.text, password_controller.text);
                        if(result.status=="OK")
                        {
                          if(mounted)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Login success"));
                            print(result.token);

                            // Delete existing token and store new token
                            database_delete_settings("token");
                            database_insert_settings("token", result.token);

                            // Go to home page
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                            {
                              return const Page_Overview();
                            },
                            ));
                          }
                        }
                        else
                        {
                          if(mounted)
                          {
                            dialog_information_show(context, "Error", result.message);
                          }
                        }
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Enter username and passsword"));
                      }
                    }
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    child: Text("Signup"),
                    onPressed: () async
                    {
                      if(username_controller.text.isNotEmpty && password_controller.text.isNotEmpty)
                      {
                        final result = await backend_signup(username_controller.text, password_controller.text);
                        if(result.status=="OK")
                        {
                          if(mounted)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Signup success"));
                          }
                        }
                        else
                        {
                          if(mounted)
                          {
                            dialog_information_show(context, "Error", result.message);
                          }
                        }
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Enter username and passsword"));
                      }
                    }
                  ),
                ]
              ),

              SizedBox(height: 32),
              TextButton(
                child: Text("Continue without account"),
                onPressed: ()
                {
                  //print("UI > Button press > Continue without account");
                  // Delete existing token and store new token
                  database_delete_settings("token");

                  // Go to home page
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                  {
                    return const Page_Overview();
                  },
                  ));
                }
              ),

            ],
          )
        )
      ),
    );
  }
}
