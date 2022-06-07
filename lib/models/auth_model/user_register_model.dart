import 'dart:convert';
import 'dart:core';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserRegisterModel {
  // サーバー側にユーザー情報を追加する
  Future<int> postUserData(firebaseUid, isActive) async {
    // URLの設定
    String url = "${dotenv.env["URL"]}/api/register";
    Map<String, String> headers = {'content-type': 'application/json'};
    String body =
        json.encode({'firebase_uid': '$firebaseUid', 'is_active': '$isActive'});
    final response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }
}
