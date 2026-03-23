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

  String backend_url = await database_get_settings_backendurl();
  final url = Uri.parse("${backend_url}upload/nutrition");

  var request = http.MultipartRequest("POST", url);
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
    //print("Backend>Response: ${response.statusCode}");
    //print("Backend>Response: ${response.body}");
  }
  else
  {
    {
      print("Backend: Error");
      print("Backend>Status code: ${response.statusCode}");
      print("Backend>Response: ${response.body}");
    }
  }

  return NutritionImageResponse(
    response.statusCode.toString(),
    "N/A",
    "N/A"
  );
}

class RecommendationData{
  String title;
  String subtitle;
  String description;

  RecommendationData(this.title, this.subtitle, this.description);
}

class InsightData{
  String title;
  String subtitle;
  String description;

  InsightData(this.title, this.subtitle, this.description);
}

class BackendMLData{
  int response_code;
  String response_body;

  String type;
  int score;

  List<RecommendationData> recommendations;
  List<InsightData> insights;

  BackendMLData(this.response_code, this.response_body, this.type, this.score, this.recommendations, this.insights);
}

Future<BackendMLData> backend_send_data(List<dynamic> data, String url_trail) async
{
  print("Backend: Sending data (length ${data.length})");

  String backend_url = await database_get_settings_backendurl();
  final url = Uri.parse("${backend_url}${url_trail}");

  print("Backend: URL is ${url}");

  try
  {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
        {
          "version":"0.1.1",
          "data": data,
        }
      ),
    );


    if(response.statusCode==200)
    {
      print("Backend: Success");

      int response_score = -1;
      String response_type = "N/A";

      List<RecommendationData> response_recommendations = [];
      List<InsightData> response_insights = [];

      bool isDecoded = false;

      try
      {
        final response_decoded = jsonDecode(response.body);
        //print(response_decoded);

        response_type = response_decoded["type"];
        response_score = response_decoded["score"];

        for(var recommendation in response_decoded["recommendation"])
        {
          response_recommendations.add(
            RecommendationData(recommendation[0], recommendation[1], recommendation[2])
          );
        }

        for(var insight in response_decoded["insight"])
        {
          response_insights.add(
            InsightData(insight[0], insight[1], insight[2])
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
        return BackendMLData(
          response.statusCode,
          response.body,
          response_type,
          response_score,
          response_recommendations,
          response_insights
        );
      }
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
    return BackendMLData(
      -1,
      "$e",
      "ERROR",
      -1,
      [],
      [],
    );
  }

  return BackendMLData(
    -1,
    "Unknown error",
    "ERROR",
    -1,
    [],
    [],
  );
}


Future<BackendMLData> backend_send_map(Map<String, dynamic> data, String url_trail) async
{
  print("Backend: Sending data (length ${data.length})");

  String backend_url = await database_get_settings_backendurl();
  String token = await database_get_settings_token();

  final url = Uri.parse("${backend_url}${url_trail}");

  print("Backend: URL is ${url}");

  try
  {
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

      int response_score = -1;
      String response_type = "N/A";

      List<RecommendationData> response_recommendations = [];
      List<InsightData> response_insights = [];

      bool isDecoded = false;

      try
      {
        final response_decoded = jsonDecode(response.body);
        //print(response_decoded);

        response_type = response_decoded["type"];
        response_score = response_decoded["score"];

        for(var recommendation in response_decoded["recommendation"])
        {
          response_recommendations.add(
            RecommendationData(recommendation[0], recommendation[1], recommendation[2])
          );
        }

        for(var insight in response_decoded["insight"])
        {
          response_insights.add(
            InsightData(insight[0], insight[1], insight[2])
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
        return BackendMLData(
          response.statusCode,
          response.body,
          response_type,
          response_score,
          response_recommendations,
          response_insights
        );
      }
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
    return BackendMLData(
      -1,
      "$e",
      "ERROR",
      -1,
      [],
      [],
    );
  }

  return BackendMLData(
    -1,
    "Unknown error",
    "ERROR",
    -1,
    [],
    [],
  );
}
