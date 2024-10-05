import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:zenith/app/constants/api_urls.dart';
import 'package:zenith/app/constants/http_codes.dart';
import 'package:zenith/core/exceptions/http_exceptions.dart';

class HttpService {
  final String baseUrl;
  final Duration timeout;

  HttpService({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 15),
  });
  Future<dynamic> get(String path) async {
    try {
      final uri = Uri.parse(baseUrl + path);
      // final token = AuthProvider.token;
      final response = await http.get(uri, headers: {
        // 'Authorization': token,
        'Content-Type': 'application/json',
      }).timeout(timeout);
      _handleErrors(response);
      return json.decode(response.body);
    } on SocketException {
      throw const SocketException("No internet connection");
    } on TimeoutException {
      throw TimeoutException('API not responded in time');
    }
  }

  void _handleErrors(http.Response response) {
    final url = response.request?.url;

    switch (response.statusCode) {
      case HttpCodes.OK:
      case HttpCodes.Accepted:
      case HttpCodes.Created:
        return;

      case HttpCodes.BadRequest:
        throw BadRequestException("$url");

      case HttpCodes.Unauthorized:
      case HttpCodes.Forbidden:
        throw UnauthorizedException("$url");

      case HttpCodes.NotFound:
        throw BadRequestException("$url");

      case HttpCodes.InternalServerError:
      case HttpCodes.ServiceUnavailable:
      case HttpCodes.GatewayTimeout:
      default:
        throw HttpException('UnknownException', response.statusCode, "$url");
    }
  }
}
