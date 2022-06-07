import 'dart:convert';
import 'dart:core';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthTokenModel {
  final _storage = const FlutterSecureStorage();

  // サーバーからAccessトークンを取得する
  // Future<int> getAccessToken(email, password) async {
  //   String url = "${dotenv.env["URL"]}/api/token";
  //   Map<String, String> headers = {'content-type': 'application/json'};
  //   String body = json.encode({'email': '$email', 'password': '$password'});
  //   final response =
  //       await http.post(Uri.parse(url), headers: headers, body: body);
  //   if (response.statusCode == 200) {
  //     var res = jsonDecode(response.body);
  //     await _storage.write(key: 'accessToken', value: res['access_token']);
  //     return response.statusCode;
  //   } else {
  //     return response.statusCode;
  //   }
  // }

  // Token保存
  Future setAccessKey(token) async {
    await _storage.write(key: 'accessToken', value: token);
  }

  // Token読み出し
  Future<String?> readAccessKey() async {
    String? accessToken = await _storage.read(key: 'accessToken');
    return accessToken;
  }
}
