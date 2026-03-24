import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'database.dart';

//String backend_url = "http://127.0.0.1:8000/";

dynamic server_getresponse(String url) async
{
  var response = await http.get(Uri.parse(url));
  var response_decoded = json.decode(response.body);

  var server_status = response_decoded["status"];
  var server_version = response_decoded["version"];

  print("Server>Status: $server_status");
  print("Server>Version: $server_version");

  return response_decoded;
}

void backend_test() async
{
  print("Backend: Testing");
  //var response_decoded = await server_getresponse("${backend_url}client/version/0.1.1");
  String backend_url = await database_get_settings_backendurl();
  final url = Uri.parse("${backend_url}client/version");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
      {
        "version":"0.1.1"
      }
    ),
  );

  if(response.statusCode==200)
  {
    print("Backend: Success");
    print("Backend>Response: ${response.body}");
  }
  else
  {
    {
      print("Backend: Error");
      print("Backend>Status code: ${response.statusCode}");
    }
  }
}

class UserLogin
{
  String status;
  String message;

  String token;
  String type;

  UserLogin(this.status, this.message, this.token, this.type);
}

Future<UserLogin> backend_login(String username, String password) async
{
  print("Backend: Logging in");
  String backend_url = await database_get_settings_backendurl();
  final url = Uri.parse("${backend_url}login");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
      {
        "username":username,
        "password":password,
      }
    ),
  );

  if(response.statusCode==200)
  {
    print("Backend: Sending success");
    try
    {
      final response_json = jsonDecode(response.body);
      final status = response_json["status"];
      if(status=="OK")
      {
        print("Backend: Login success");
        return UserLogin(
          "OK",
          response_json["message"],
          response_json["access_token"],
          response_json["token_type"]
        );
      }
      else
      {
        print("Backend: Login fail");
        return UserLogin(
          "ERROR",
          response_json["message"],
          "N/A",
          "N/A"
        );
      }
    }
    catch(e)
    {
      return UserLogin(
        "ERROR",
        "${e}",
        "N/A",
        "N/A"
      );
    }
  }
  else
  {
    print("Backend: Error");
    print("Backend>Status code: ${response.statusCode}");
    print("Backend>Response: ${response.body}");
    return UserLogin(
      "ERROR",
      "${response.body}",
      "N/A",
      "N/A"
    );
  }
}

class UserSignup
{
  String status;
  String version;
  String message;

  UserSignup(this.status, this.version, this.message);
}

Future<UserSignup> backend_signup(String username, String password) async
{
  print("Backend: Signing up");
  String backend_url = await database_get_settings_backendurl();
  final url = Uri.parse("${backend_url}signup");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(
      {
        "username":username,
        "password":password,
      }
    ),
  );

  if(response.statusCode==200)
  {
    print("Backend: Sending success");
    try
    {
      final response_json = jsonDecode(response.body);
      final status = response_json["status"];
      if(status=="OK")
      {
        print("Backend: Sign up success");
        return UserSignup(
          response_json["status"],
          response_json["version"],
          response_json["message"]
        );
      }
      else
      {
        print("Backend: Login fail");
        return UserSignup(
          response_json["status"],
          response_json["version"],
          response_json["message"]
        );
      }
    }
    catch(e)
    {
      return UserSignup(
        "ERROR",
        "N/A",
        "${e}",
      );
    }
  }
  else
  {
    print("Backend: Error");
    print("Backend>Status code: ${response.statusCode}");
    print("Backend>Response: ${response.body}");
    return UserSignup(
      "ERROR",
      "N/A",
      "${response.body}",
    );
  }
}

// LLM chat
// Image upload
class LLMResponse{
  String status;

  String version;
  String message;

  LLMResponse(this.status, this.version, this.message);
}

Future<LLMResponse> backend_send_llm(String message) async
{
  print("Backend: Sent LLM message to server");

  try
  {
    String backend_url = await database_get_settings_backendurl();
    String token = await database_get_settings_token();

    final url = Uri.parse("${backend_url}chat");

    print("Backend: URL is ${url}");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        {
          "version":"0.1.1",
          "message": message,
        }
      ),
    );


    if(response.statusCode==200)
    {
      print("Backend: Success");

      String response_status = "-1";
      String response_version = "N/A";
      String response_message = "N/A";

      bool isDecoded = false;

      try
      {
        final response_decoded = jsonDecode(response.body);

        response_status = response_decoded["status"];
        response_version = response_decoded["version"];
        response_message = response_decoded["message"];

        isDecoded = true;
      }
      catch(e)
      {
        print("Backend: Error decoding JSON");
        print("Backend>Error: ${e}");
      }

      if(isDecoded)
      {
        return LLMResponse(
          response_status,
          response_version,
          response_message
        );
      }
    }
    else if(response.statusCode==401)
    {
      return LLMResponse(
        "401",
        "N/A",
        "Authentication error"
      );
    }
    else
    {
      {
        print("Backend: Error");
        print("Backend>Status code: ${response.statusCode}");
        print("Backend>Response: ${response.body}");
      }
    }
  }
  catch(e)
  {
    return LLMResponse(
      "ERROR",
      "N/A",
      "$e"
    );
  }

  return LLMResponse(
    "ERROR",
    "N/A",
    "Unknown error"
  );
}

// Image upload
class NutritionImageResponse{
  String status;

  String name;
  String calories;

  NutritionImageResponse(this.status, this.name, this.calories);
}

Future<NutritionImageResponse> backend_send_nutrition_image(File image) async
{
  print("Backend: Image upload");

  try
  {
    String backend_url = await database_get_settings_backendurl();
    String token = await database_get_settings_token();

    final url = Uri.parse("${backend_url}upload/nutrition");

    var request = http.MultipartRequest("POST", url);
    request.headers.addAll({
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    });

    var stream = http.ByteStream(image.openRead());
    var length = await image.length();
    var filename = image.path.split("/").last;

    var multipart_file = http.MultipartFile(
      "file_upload",
      stream,
      length,
      filename: filename,
    );

    request.files.add(multipart_file);

    var response_streamed = await request.send();
    var response = await http.Response.fromStream(response_streamed);

    final response_json = jsonDecode(response.body);

    if(response.statusCode==200)
    {
      print("Backend: Success");
      return NutritionImageResponse(
        response_json["status"],
        response_json["nutrition_name"],
        response_json["nutrition_calories"].toString()
      );
    }
    else
    {
      print("Backend: Error");
      print("Backend>Status code: ${response.statusCode}");
      print("Backend>Response: ${response.body}");

      return NutritionImageResponse(
        "${response.statusCode}",
        "${response.body}",
        "N/A"
      );
    }
  }
  catch(e)
  {
    return NutritionImageResponse(
      "ERROR",
      "N/A",
      "N/A"
    );
  }
}

class RecommendationData{
  String status;
  String version;
  String message;

  String datetime;

  RecommendationData(this.status, this.version, this.message, this.datetime);
}

class InsightData{
  String title;
  String subtitle;
  String description;

  int score;

  InsightData(this.title, this.subtitle, this.description, this.score);
}

class BackendInsightData{
  int status;
  String body;

  String type;

  List<int> scores;
  List<InsightData> insights;

  BackendInsightData(this.status, this.body, this.type, this.scores, this.insights);
}

Future<BackendInsightData> backend_send_map(Map<String, dynamic> data, String url_trail) async
{
  print("Backend: Sending data (length ${data.length})");

  try
  {
    String backend_url = await database_get_settings_backendurl();
    String token = await database_get_settings_token();

    final url = Uri.parse("${backend_url}${url_trail}");

    print("Backend: URL is ${url}");


    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonEncode(data),
    );

    if(response.statusCode==200)
    {
      print("Backend: Success");

      List<int> response_score = [];
      String response_type = "N/A";

      List<InsightData> response_insights = [];

      bool isDecoded = false;

      try
      {
        final response_decoded = jsonDecode(response.body);
        //print(response_decoded);

        response_type = response_decoded["type"];

        final response_score_json = response_decoded["scores"];


        // Hacky way to enter scores
        if(response_score_json.length==11)
        {
          int academic_scores = 0;

          academic_scores += response_score_json[0] as int;
          academic_scores += response_score_json[1] as int;
          academic_scores += response_score_json[2] as int;

          database_insert_score("academics", academic_scores);

          database_insert_score("activity", response_score_json[3]);
          database_insert_score("bodymeasurement", response_score_json[4]);
          database_insert_score("mind_mood", response_score_json[5]);
          database_insert_score("nutrition", response_score_json[6]);
          database_insert_score("symptom", response_score_json[7]);
          database_insert_score("time", response_score_json[8]);
          database_insert_score("vitals", response_score_json[9]);
          database_insert_score("workout", response_score_json[10]);
        }
        /*
         academics_absent
         academics_assignment
         academics_mark
         activity
         bodymeasurement
         mind_mood
         nutrition
         symptom
         time
         vitals
         workout
         */

        for(var insight in response_decoded["insight"])
        {
          //print(insight[0]);
          response_insights.add(
            InsightData(insight[0], insight[1], insight[2], -1)
          );
        }

        isDecoded = true;
      }
      catch(e)
      {
        print("Backend: Error decoding JSON");
        print("Backend>Error: ${e}");
      }

      if(isDecoded)
      {
        return BackendInsightData(
          response.statusCode,
          response.body,
          response_type,
          response_score,
          response_insights
        );
      }
    }
    else if(response.statusCode==401)
    {
      return BackendInsightData(
        401,
        "Authentication error",
        "ERROR",
        [],
        [],
      );
    }
    else
    {
      {
        print("Backend: Error");
        print("Backend>Status code: ${response.statusCode}");
        print("Backend>Response: ${response.body}");
      }
    }
  }
  catch(e)
  {
    return BackendInsightData(
      -1,
      "$e",
      "ERROR",
      [],
      [],
    );
  }

  return BackendInsightData(
    -1,
    "Unknown error",
    "ERROR",
    [],
    [],
  );
}
