import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'database.dart';

import 'api_keys.dart';
// Format is String roboflow_api_key = "<YOUR_API_KEY>";

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


// Image recognised resposne
class NutritionPredictions
{
  String name;
  double confidence;
  int calories;

  NutritionPredictions(this.name, this.confidence, this.calories);
}

// Image upload
class NutritionImageResponse{
  String status;
  String message;

  List<NutritionPredictions> result;
  NutritionImageResponse(this.status, this.message, this.result);
}

Future<NutritionImageResponse> backend_send_nutrition_image(File image) async
{
  print("Backend: Image upload");

  final calorie_map = {
    "appam": 120,
    "aviyal": 150,
    "beef": 250,
    "biriyani": 300,
    "chappati": 120,
    "chicken_curry": 220,
    "chicken_fry": 280,
    "chutney": 80,
    "dosa": 130,
    "egg_curry": 180,
    "fish_fry": 200,
    "idiyappam": 150,
    "idli": 70,
    "kadala_curry": 180,
    "kappa": 160,
    "noodles": 220,
    "oothappam": 180,
    "paneer": 260,
    "pappadam": 60,
    "pathiri": 120,
    "payar": 140,
    "porotta": 250,
    "puri": 150,
    "rice": 200,
    "sambar": 100,
    "upma": 180,
    "vada": 140,
  };

  try
  {
    //String token = await database_get_settings_token();

    final url = Uri.parse("https://serverless.roboflow.com/foodfood/5?api_key=${roboflow_api_key}");

    var request = http.MultipartRequest("POST", url);

    var stream = http.ByteStream(image.openRead());
    var length = await image.length();
    var filename = image.path.split("/").last;

    var multipart_file = http.MultipartFile(
      "file",
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

      List<NutritionPredictions> result = [];

      //print(response_json);

      for (var item in response_json["predictions"])
      {
        if (item["confidence"] > 0.5)
        {
          int item_calories = -1;
          final item_confidence = item["confidence"]*100;
          String item_name = item["class"];

          if(calorie_map.containsKey(item_name))
          {
            item_calories = calorie_map[item_name] ?? -1;
          }

          result.add(NutritionPredictions(
            item_name,
            item_confidence,
            item_calories
          ));
        }
      }

      return NutritionImageResponse(
        "OK",
        "Success",
        result
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
        []
      );
    }
  }
  catch(e)
  {
    return NutritionImageResponse(
      "ERROR",
      "${e}",
      [],
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

    // Get user details and goals
    int height_result = await database_get_goal("height");
    int weight_result = await database_get_goal("weight");
    int age_result = await database_get_goal("age");
    int gender_result = await database_get_goal("gender");

    int steps_result = await database_get_goal("steps");
    int distance_result = await database_get_goal("distance");
    int calories_result = await database_get_goal("calories");

    int study_result = await database_get_goal("study");
    int sleep_result = await database_get_goal("sleep");
    int exercise_result = await database_get_goal("exercise");

    String gender;
    if(gender_result==0)
    {
      gender = "F";
    }
    else
    {
      gender = "M";
    }

    Map<String,dynamic> goals = {
      "height":height_result,
      "weight":weight_result,
      "age":age_result,
      "gender":gender,

      "steps":steps_result,
      "distance":distance_result,
      "calories":calories_result,

      "study":study_result,
      "sleep":sleep_result,
      "exercise":exercise_result,
    };

    data["goals"]= goals;

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

          academic_scores = (academic_scores/3).toInt();

          database_delete_score();

          database_insert_score("academics", academic_scores);

          database_insert_score("activity", response_score_json[3]);
          database_insert_score("bodymeasurement", response_score_json[4]);
          database_insert_score("mind_mood", 75);
          //database_insert_score("mind_mood", response_score_json[5]);
          database_insert_score("nutrition", response_score_json[6]);
          database_insert_score("symptom", 75);
          //database_insert_score("symptom", response_score_json[7]);
          database_insert_score("time", 75);
          //database_insert_score("time", response_score_json[8]);
          database_insert_score("vitals", 75);
          //database_insert_score("vitals", response_score_json[9]);
         // database_insert_score("workout", response_score_json[10]);
          database_insert_score("workout", 75);

          //int total_score=0;
          //for(var score_s in response_score_json)
          //{
          //  final score = score_s as int;
          //  print(score);
          //  total_score+=score;
          //}
          //final total_score_d = 100*(academic_scores/900);
          //print("Total score is $total_score_d");
          //database_insert_score("total", total_score_d.toInt());
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
