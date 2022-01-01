import 'dart:convert';

import 'package:async/async.dart';
import 'package:auth/src/infra/api/mapper.dart';
import 'package:http/http.dart' as http;
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';

class AuthApi implements IAuthApi {
  final http.Client _client;
  String? baseUrl;

  AuthApi(this.baseUrl, this._client);

  @override
  Future<Result<String>> signIn(Credential credential) async {
    var endPoint = baseUrl! + '/auth/signin';
    return await _postCredential(endPoint, credential);
  }

  @override
  Future<Result<String>> signUp(Credential credential) async {
    var endPoint = baseUrl! + '/auth/signup';
    return await _postCredential(endPoint, credential);
  }

  Future<Result<String>> _postCredential(
      String? endpoint, Credential credential) async {
    var response = await _client.post(Uri.parse(endpoint!),
        body: Mapper.toJson(credential));

    if (response.statusCode != 200) return Result.error('Server Error');
    var json = jsonDecode(response.body);

    return json['auth_token'] != null
        ? Result.value(json['auth_token'])
        : Result.error(json['message']);
  }
}
