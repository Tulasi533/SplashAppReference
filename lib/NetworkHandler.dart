import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  // http://192.168.0.105:5000
  // https://damp-ridge-81846.herokuapp.com
  String baseurl = "http://192.168.0.103:5000";
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();


  Future get(String url)async
  {
    String? token = await storage.read(key: "token");
    url = formater(url);
    // /user/register
    var response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Bearer $token"}
    );
    if(response.statusCode == 200 || response.statusCode == 201)
    {
      log.i(response.body);
      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async
  {
    String? token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      Uri.parse(url), 
      headers: {
        "Content-type": "application/json", 
        "Authorization": "Bearer $token"
      }, 
      body: json.encode(body)
    );
    return response;
  }

  Future<http.Response> delete(String url) async {
    url = formater(url);
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
      },
    );

    return response;
  }
  Future<http.Response> post1(String url, var body) async
  {
    String? token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.post(
      Uri.parse(url), 
      headers: {
        "Content-type": "application/json", 
        "Authorization": "Bearer $token"
      }, 
      body: json.encode(body)
    );
    return response;
  }

  Future<http.Response> patch(String url, Map<String, dynamic> body) async
  {
    String? token = await storage.read(key: "token");
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      Uri.parse(url), 
      headers: {
        "Content-type": "application/json", 
        "Authorization": "Bearer $token"
      }, 
      body: json.encode(body)
    );
    return response;
  }

  Future<http.StreamedResponse> patchImage(String url, String filepath) async{
    url = formater(url);
    String? token = await storage.read(key: "token");
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("img", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer $token"
    });
    var response = request.send();
    return response;
  }

  Future<http.StreamedResponse> postFile(String url, String filepath) async{
    url = formater(url);
    String? token = await storage.read(key: "token");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath("uploadfile", filepath));
    request.headers.addAll({
      "Content-type": "multipart/form-data"
    });
    var response = request.send();
    return response;
  }

  String formater(String url)
  {
    return baseurl+url;
  }

  NetworkImage getImage(String imagename) {
    String url = formater("/uploads//$imagename.jpg");
    return NetworkImage(url);
  }
}