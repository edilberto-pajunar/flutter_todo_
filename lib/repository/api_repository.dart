import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_project_template/model/request.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  static http.Client client = http.Client();

  static Uri uri(baseUrl) => Uri.parse("https://$baseUrl");

  static String urlWithParams(String endpoint, Map<String, dynamic>? params) {
    endpoint = "$endpoint?";
    if (params == null) {
      return endpoint;
    }
    params.forEach((key, value) {
      if (value is List) {
        for (var category in value) {
          endpoint += "$key=$category&";
        }
      } else {
        endpoint += "$key=$value&";
      }
    });
    return endpoint;
  }

  static headers() async {
    return {
      HttpHeaders.acceptHeader: "application/json",
      // HttpHeaders.authorizationHeader:
      //     "Bearer ${await const FlutterSecureStorage().read(key: "bearer")}",
      HttpHeaders.contentTypeHeader: "application/json; charset=utf-8",
    };
  }

  send(RequestModel req) async {
    late http.Response httpResponse;
    var url = uri(req.url + req.endpoint);
    log("Called API: $url");

    if (req.type == RequestType.get) {
      httpResponse = await client.get(url, headers: await headers());
    } else if (req.type == RequestType.post) {
      httpResponse = await client.post(
        url,
        headers: await headers(),
        body: jsonEncode(req.data),
      );
    } else if (req.type == RequestType.delete) {
      httpResponse = await client.delete(
        url,
        headers: await headers(),
        body: jsonEncode(req.data),
      );
    } else if (req.type == RequestType.patch) {
      httpResponse = await client.patch(
        url,
        headers: await headers(),
        body: jsonEncode(req.data),
      );
    } else if (req.type == RequestType.put) {
      // TODO implement method here
      throw "request not implemented.";
    } else if (req.type == RequestType.update) {
      // TODO implement method here
      throw "request not implemented.";
    }

    debugPrint(
        "/////////////////////////////////////////////////////////////////////////////////////////////////////");

    if (httpResponse.statusCode == 200) {
      log("API Success!");
      return jsonDecode(httpResponse.body);
    } else if (httpResponse.statusCode == 500) {
      throw "Something went wrong";
    } else {
      log("API Error: ${httpResponse.statusCode} ${httpResponse.body}");
      var error = jsonDecode(httpResponse.body);
      if (error.containsKey("errors")) {
        return error;
      } else {
        throw error["message"];
      }
    }
  }

  static void cancelApiCall() {
    client.close();
    client = http.Client();
  }
}
