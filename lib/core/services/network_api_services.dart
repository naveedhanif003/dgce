import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../utils/helpers/apiException.dart'; // For debugging logs

class NetworkApiService {
  final String baseUrl = "https://test.dhinvest.ae"; // Replace with your API base URL
  // final String baseUrl = "https://dgce.co"; // Replace with your API base URL

  /// Generic Function for GET Requests
  Future<dynamic> getRequest(
      String endpoint, {
        Map<String, String>? headers,
        Map<String, String>? params, // Add this line for parameters
      }) async {
    try {
      String queryString = params != null ? "?${Uri(queryParameters: params).query}" : "";
      Uri url = Uri.parse("$baseUrl$endpoint$queryString");

      // Log Request
      debugPrint("➡️ [GET] Request: $url");
      debugPrint("📜 Headers: ${headers ?? "None"}");

      final response = await http.get(url, headers: headers);

      // Log Response
      debugPrint("✅ [GET] Response: ${response.statusCode}");
      debugPrint("📜 Body: ${response.body}");

      return _processResponse(response);
    } catch (e) {
      debugPrint("❌ Network Error: $e");
      throw ApiException("Network Error: $e");
    }
  }

  /// Generic Function for POST Requests
  Future<dynamic> postRequest(
      String endpoint, {
        Map<String, String>? headers,
        Map<String, dynamic>? body, // Update body to accept parameters
      }) async {
    try {
      Uri url = Uri.parse("$baseUrl$endpoint");

      // Log Request
      debugPrint("➡️ [POST] Request: $url");
      debugPrint("📜 Headers: ${headers ?? "None"}");
      debugPrint("📤 Body: ${jsonEncode(body)}");

      final response = await http.post(
        url,
        headers: headers ?? {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      // Log Response
      debugPrint("✅ [POST] Response: ${response.statusCode}");
      debugPrint("📜 Body: ${response.body}");

      return _processResponse(response);
    } catch (e) {
      debugPrint("❌ Network Error: $e");
      throw ApiException("Network Error: $e");
    }
  }

  /// Process API Response and Handle Errors
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        throw ApiException("Bad Request: ${response.body}");
      case 401:
      case 403:
        throw ApiException("Unauthorized Access: ${response.body}");
      case 404:
        throw ApiException("Not Found: ${response.body}");
      case 500:
        throw ApiException("Server Error: ${response.body}");
      default:
        throw ApiException("Error: ${response.statusCode} - ${response.body}");
    }
  }
}

