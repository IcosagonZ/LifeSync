import 'dart:convert';
import 'package:http/http.dart' as http;

String backend_url = "http://127.0.0.1:8000/";

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

Future<BackendMLData> backend_send(List<dynamic> data, String url_trail) async
{
  print("Backend: Sending data (length ${data.length})");

  final url = Uri.parse("${backend_url}recommendations/${url_trail}");

  print("Backend: URL is ${url}");

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

  return BackendMLData(
    response.statusCode,
    response.body,
    "N/A",
    -1,
    [],
    [],
  );
}
