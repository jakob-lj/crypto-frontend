import 'package:http/http.dart' as http;
import 'dart:convert';
import 'auth.dart';

class DClient {
  void doWork() {
    print("doing work");
  }
}

class HttpClient {

  String baseUrl = "http://localhost:8080";

  postWithHeaders(extension, header, body) async {
    var response = await http.post(
      baseUrl + extension,
      headers: Map.from(header),
      body: body,
    );

    return jsonDecode(response.body);
  }

  post(extension, body) async {
    var response = await http.post(
      baseUrl + extension,
      headers: getAuthInfo(),
      body: body
    );
    return jsonDecode(response.body);
  }

  get(extension, header) async {
    var response = await http.read(baseUrl + extension);
    print("get" + response.runtimeType.toString());
    return response;
  }

  getAuthInfo() {
    Auth auth = Auth.getInstance();
    if (auth.getCurrentUser() != null) {
      return auth.getAuthorization();
    }
    return {};
  }
}