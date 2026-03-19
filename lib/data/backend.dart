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

void backend_send(List<dynamic> data) async
{
  print("Backend: Sending data (length ${data.length})");

  final url = Uri.parse("${backend_url}data/vitals");

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
    print("Backend>Response: ${response.body}");
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
