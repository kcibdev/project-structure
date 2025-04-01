import 'dart:io';

import 'package:agent/src/common/utils/constants.dart';
import 'package:agent/src/core/api/api_client.dart';
import 'package:agent/src/core/api/model/response_model.dart';
import 'package:agent/src/routes/app_routes.dart';

class RepoIndex {
  ApiClient client = ApiClient();

  Future<ResponseModel> postBody(String url, Map<String, dynamic> body) async {
    final ResponseModel res = await client.postApi(url, body);

    if (res.statusCode == 401 && url != Constants.endpoint.user) {
      routes.pushNamed(AppRoute.login, extra: 'unauthorized');
    }
    return res;
  }

  Future<ResponseModel> getBody(String url,
      {Map<String, String>? header}) async {
    final ResponseModel res = await client.getApi(url, headers: header);

    if (res.statusCode == 401 && url != Constants.endpoint.user) {
      routes.pushNamed(AppRoute.login, extra: 'unauthorized');
    }

    return res;
  }

  Future<ResponseModel> putBody(String url, Map<String, dynamic> body,
      {Map<String, String>? header}) async {
    final ResponseModel res = await client.putApi(url, body, headers: header);

    if (res.statusCode == 401 && url != Constants.endpoint.user) {
      routes.pushNamed(AppRoute.login, extra: 'unauthorized');
    }

    return res;
  }

  Future<ResponseModel> deleteBody(String url,
      {Map<String, String>? header}) async {
    final ResponseModel res = await client.deleteApi(url, headers: header);

    if (res.statusCode == 401 && url != Constants.endpoint.user) {
      routes.pushNamed(AppRoute.login, extra: 'unauthorized');
    }
    return res;
  }

  Future<ResponseModel> fileBody(
    String url,
    File file,
    String name,
    Map<String, String> data,
  ) async {
    final ResponseModel res =
        await client.uploadFile(url, file, name, body: data);

    if (res.statusCode == 401 && url != Constants.endpoint.user) {
      routes.pushNamed(AppRoute.login, extra: 'unauthorized');
    }

    return res;
  }

  Future<ResponseModel> filePutBody(
    String url,
    File file,
    String name,
    Map<String, String> data,
  ) async {
    final ResponseModel res =
        await client.uploadFilePut(url, file, name, body: data);

    if (res.statusCode == 401 && url != Constants.endpoint.user) {
      routes.pushNamed(AppRoute.login, extra: 'unauthorized');
    }

    return res;
  }

  Future<ResponseModel> filesBody(
      String url, List<File> body, String name) async {
    final ResponseModel res = await client.uploadFiles(url, body, name);

    if (res.statusCode == 401 && url != Constants.endpoint.user) {
      routes.pushNamed(AppRoute.login, extra: 'unauthorized');
    }

    return res;
  }
}
