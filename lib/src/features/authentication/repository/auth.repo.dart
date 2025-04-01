import 'package:agent/src/common/utils/constants.dart';
import 'package:agent/src/core/api/model/response_model.dart';
import 'package:agent/src/core/api/repository/repo_index.dart';

class AuthRepo {
  RepoIndex index = RepoIndex();

  Future<ResponseModel> login(Map<String, dynamic> body) async =>
      index.postBody(Constants.endpoint.login, body);
}
