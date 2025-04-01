import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agent/src/common/extensions/string.dart';
import 'package:agent/src/common/utils/constants.dart';
import 'package:agent/src/core/api/model/response_model.dart';
import 'package:agent/src/core/api/response_handling.dart';
import 'package:agent/src/core/storage/preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class ApiClient {
  late Map<String, String> _headers;
  ResponseHandler handling = ResponseHandler();
  String timeoutMessage = 'Connection error, please check your internet';
  String errorMessage = 'Error connecting to server';
  String noInternetMessage =
      'Please check your internet connection and try again';
  int timeoutInSeconds = 200;
  static String requestURI = Constants.endpoint.baseUrl;

  String token = Prefs.token;

  ApiClient() {
    _headers = {
      'Accept': 'application/json',
      // 'device-id': Prefs.getString(Config.deviceID),
      // 'device-model': Prefs.getString(Config.deviceModel),
      'authorization': 'Bearer ${token.isEmpty ? Prefs.token : token}',
      // 'app_version': Prefs.getString(Config.appVersion),
    };
  }

  void updateHeader(String newToken) {
    _headers = {
      'Accept': 'application/json',
      // 'device-id': Prefs.getString(Config.deviceID),
      // 'device-model': Prefs.getString(Config.deviceModel),
      'authorization': 'Bearer $newToken',
      // 'app_version': Prefs.getString(Config.appVersion),
    };
  }

  Future<ResponseModel> getApi(String uri,
      {Map<String, String>? headers}) async {
    try {
      updateHeader(Prefs.token);

      final startTime = DateTime.now();

      final http.Response response0 = await http
          .get(Uri.parse('$requestURI$uri'), headers: headers ?? _headers)
          .timeout(Duration(seconds: timeoutInSeconds));
      final ResponseModel response = handling.handleResponse(response0,
          startTime: startTime, headers: headers ?? _headers);
      return response;
    } on TimeoutException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Duration  :===>    [${err.duration}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': timeoutMessage,
        'status': false,
      });
    } on SocketException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Address  :===>    [${err.address}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': noInternetMessage,
        'status': false,
      });
    } on FormatException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          FormatException Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Source    :===>    [${err.source}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    } catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Catch Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    }
  }

  Future<ResponseModel> postApi(String uri, Map<String, dynamic>? body,
      {Map<String, String>? headers}) async {
    try {
      updateHeader(Prefs.token);

      final startTime = DateTime.now();

      final http.Response response0 = await http
          .post(
            Uri.parse('$requestURI$uri'),
            body: body,
            headers: headers ?? _headers,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      final ResponseModel response = handling.handleResponse(response0,
          requestBody: body,
          startTime: startTime,
          headers: headers ?? _headers);
      return response;
    } on TimeoutException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Duration  :===>    [${err.duration}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': timeoutMessage,
        'status': false,
      });
    } on SocketException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Address  :===>    [${err.address}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': noInternetMessage,
        'status': false,
      });
    } on FormatException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          FormatException Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Source    :===>    [${err.source}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    } catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Catch Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    }
  }

  Future<ResponseModel> putApi(String uri, Map<String, dynamic> body,
      {Map<String, String>? headers}) async {
    try {
      updateHeader(Prefs.token);
      final startTime = DateTime.now();
      final http.Response response0 = await http
          .put(Uri.parse(uri.isURL ? uri : '$requestURI$uri'),
              body: jsonEncode(body), headers: headers ?? _headers)
          .timeout(Duration(seconds: timeoutInSeconds));
      final ResponseModel response = handling.handleResponse(response0,
          requestBody: body,
          startTime: startTime,
          headers: headers ?? _headers);
      return response;
    } on TimeoutException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Duration  :===>    [${err.duration}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': timeoutMessage,
        'status': false,
      });
    } on SocketException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Address  :===>    [${err.address}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': noInternetMessage,
        'status': false,
      });
    } on FormatException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          FormatException Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Source    :===>    [${err.source}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    } catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Catch Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    }
  }

  Future<ResponseModel> deleteApi(String uri,
      {Map<String, String>? headers}) async {
    try {
      updateHeader(Prefs.token);
      final startTime = DateTime.now();
      final http.Response response0 = await http
          .delete(Uri.parse('$requestURI$uri'), headers: headers ?? _headers)
          .timeout(Duration(seconds: timeoutInSeconds));
      final ResponseModel response = handling.handleResponse(response0,
          startTime: startTime, headers: headers ?? _headers);
      return response;
    } on TimeoutException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Duration  :===>    [${err.duration}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': timeoutMessage,
        'status': false,
      });
    } on SocketException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Address  :===>    [${err.address}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': noInternetMessage,
        'status': false,
      });
    } on FormatException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          FormatException Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Source    :===>    [${err.source}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    } catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Catch Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    }
  }

  Future<ResponseModel> uploadFile(String uri, File file, String name,
      {Map<String, String>? headers,
      Map<String, String> body = const {}}) async {
    try {
      final startTime = DateTime.now();
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$requestURI$uri'),
      );

      _headers['Content-Type'] = 'multipart/form-data';
      // Setting headers
      request.headers.addAll(headers ?? _headers);

      // Adding fields (form data)
      request.fields.addAll(body);

      // Adding the file
      request.files.add(await http.MultipartFile.fromPath(name, file.path));

      // Sending the request
      final http.StreamedResponse streamedResponse = await request.send();
      final http.Response response =
          await http.Response.fromStream(streamedResponse);
      // Handling the response
      final ResponseModel customResponse = handling.handleResponse(response,
          startTime: startTime, headers: headers ?? _headers);
      return customResponse;
    } on TimeoutException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Duration  :===>    [${err.duration}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': timeoutMessage,
        'status': false,
      });
    } on SocketException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Address  :===>    [${err.address}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': noInternetMessage,
        'status': false,
      });
    } on FormatException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          FormatException Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Source    :===>    [${err.source}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    } catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Catch Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    }
  }

  Future<ResponseModel> uploadFilePut(String uri, File file, String name,
      {Map<String, String>? headers,
      Map<String, String> body = const {}}) async {
    try {
      final startTime = DateTime.now();
      final request = http.MultipartRequest(
        'PUT',
        Uri.parse('$requestURI$uri'),
      );

      _headers['Content-Type'] = 'multipart/form-data';
      // Setting headers
      request.headers.addAll(headers ?? _headers);

      // Adding fields (form data)
      request.fields.addAll(body);

      // Adding the file
      request.files.add(await http.MultipartFile.fromPath(name, file.path));

      // Sending the request
      final http.StreamedResponse streamedResponse = await request.send();
      final http.Response response =
          await http.Response.fromStream(streamedResponse);
      // Handling the response
      final ResponseModel customResponse = handling.handleResponse(response,
          startTime: startTime, headers: headers ?? _headers);
      return customResponse;
    } on TimeoutException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Duration  :===>    [${err.duration}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': timeoutMessage,
        'status': false,
      });
    } on SocketException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Address  :===>    [${err.address}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': noInternetMessage,
        'status': false,
      });
    } on FormatException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          FormatException Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Source    :===>    [${err.source}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    } catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Catch Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    }
  }

  Future<ResponseModel> uploadFiles(String uri, List<File> files, String name,
      {Map<String, String>? headers}) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$requestURI$uri'),
      );
      final Map<String, String> headers0 = {
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'authorization': 'Bearer ${Prefs.token}',
      };

      final startTime = DateTime.now();

      request.headers.addAll(headers ?? headers0);
      for (final file in files) {
        request.files.add(
          http.MultipartFile(
            '$name[]',
            file.readAsBytes().asStream(),
            file.lengthSync(),
            filename: basename(file.path.split('/').last),
            contentType: MediaType('image', file.path.split('.').last),
          ),
        );
      }

      final http.Response response0 =
          await http.Response.fromStream(await request.send());

      final ResponseModel response =
          handling.handleResponse(response0, startTime: startTime);
      return response;
    } on TimeoutException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Duration  :===>    [${err.duration}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': timeoutMessage,
        'status': false,
      });
    } on SocketException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Timeout Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Address  :===>    [${err.address}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': noInternetMessage,
        'status': false,
      });
    } on FormatException catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          FormatException Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error Message   :===>    [${err.message}]

          **********

          Error Source    :===>    [${err.source}]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    } catch (err, stack) {
      if (kDebugMode) {
        print('''
          ====================
          Catch Error Handle
          ====================

          **********

          Error URI       :===>    [$requestURI$uri]

          **********

          Error main      :===>    $err

          **********

          Error Stack     :===>    $stack

          **********

          ''');
      }

      return ResponseModel(statusCode: 1, data: {
        'message': errorMessage,
        'status': false,
      });
    }
  }
}
