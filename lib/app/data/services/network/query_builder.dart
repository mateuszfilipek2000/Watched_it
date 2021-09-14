import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:watched_it_getx/app/data/api_keys.dart';
import 'package:watched_it_getx/app/data/services/network/enums/api_versions.dart';
import 'package:watched_it_getx/app/data/services/network/enums/request_methods.dart';
import 'package:watched_it_getx/app/data/services/network/enums/resource_types.dart';

mixin QueryBuilder {
  static const String baseUrl = "api.themoviedb.org";

  ///make sure that you pass endpoint without the resource type part, without leading slash
  ///do not pass content type header
  static Future<Map<String, dynamic>?> executeQuery(
    ResourceType resourceType,
    String endPoint, {
    HttpMethod httpMethod = HttpMethod.GET,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    ApiVersion apiVersion = ApiVersion.V3,
  }) async {
    Map<String, dynamic> _queryParameters = {
      "api_key": apiVersion == ApiVersion.V3 ? apiKeyV3 : apiReadAccessTokenV4,
    };
    if (queryParameters != null)
      _queryParameters.addEntries(queryParameters.entries);

    Map<String, String> _headers = {
      "Content-Type": "application/json;charset=utf-8",
    };
    if (headers != null) _headers.addEntries(headers.entries);

    final Uri queryUri = Uri(
      scheme: "https",
      host: baseUrl,
      path:
          "/${apiVersion == ApiVersion.V3 ? 3 : 4}/${describeEnum(resourceType)}/$endPoint",
      queryParameters: _queryParameters,
    );
    print(queryUri);

    try {
      late http.Response response;

      switch (httpMethod) {
        case HttpMethod.GET:
          response = await http.get(
            queryUri,
            headers: _headers,
          );
          break;
        case HttpMethod.POST:
          response = await http.post(
            queryUri,
            headers: _headers,
            body: body,
          );
          break;
      }
      print(response.body);
      return json.decode(response.body);
    } catch (error) {
      print(error);
    }
    return null;
  }
}
