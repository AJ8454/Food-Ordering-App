import 'dart:convert';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';

class Mockclient extends Mock implements http.Client {}

void main() {
  MockClient? client;
  AuthApi? sut;

  setUp(() {
    var fn = MockClientHandler;

    client = MockClient(fn as Future<http.Response> Function(http.Request));
    sut = AuthApi('http:baseUrl', client!);
  });

  group('signin', () {
    var credential = Credential(
      type: AuthType.email,
      email: 'email@gmail.com',
      password: 'pass',
      name: 'aj',
    );

    test('should return error when status code Successfull ', () async {
      var tokenStr = 'akcslfjs';
      when(client!.post(Uri.parse(any.toString()), body: anyNamed('body')))
          .thenAnswer((_) async =>
              http.Response(jsonEncode({'auth_token': tokenStr}), 200));

      var result = await sut!.signIn(credential);
      expect(result.asValue!.value, tokenStr);
    });
  });
}
