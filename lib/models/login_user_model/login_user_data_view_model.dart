import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mahjong_app_flutter/models/auth_model/token_model.dart';
import 'package:mahjong_app_flutter/models/group_model/group_data_model.dart';
import 'package:mahjong_app_flutter/models/login_user_model/user_data_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

final loginUserViewModel =
    ChangeNotifierProvider((_) => LoginUserDataViewModel());

class LoginUserDataViewModel extends ChangeNotifier {
  LoginUserData _loginUserData = LoginUserData("", "", 0, 0, 0, 0, 0, 0);
  List<GroupData> _groupData = [];
  final AuthTokenModel _authToken = AuthTokenModel();
  int _statusCode = 0;
  get loginUserData => _loginUserData;
  get groupData => _groupData;

  void setData(res) {
    _loginUserData = LoginUserData(
        res['nick_name'],
        res['image'],
        res['rank1'],
        res['rank2'],
        res['rank3'],
        res['rank4'],
        res['game_cnt'],
        res['score']);
    if (res['group'].length != 0) {
      for (var i = 0; i < res['group'].length; i++) {
        _groupData.add(GroupData(
            res['group'][i]['password'],
            res['group'][i]['id'],
            utf8.decode(res['group'][i]['text'].runes.toList()),
            res['group'][i]['created_at'],
            utf8.decode(res['group'][i]['title'].runes.toList()),
            res['group'][i]['image'],
            res['group'][i]['update_at']));
      }
    }
    notifyListeners();
  }

  int getStatusCode() {
    return _statusCode;
  }

  //　サーバーからログインしているユーザーのデータを取得
  Future<void> getLoginUserData() async {
    String url = "${dotenv.env["URL"]}/api/users/me/";
    // トークン取得
    String? token = await _authToken.readAccessKey();
    print(token);
    Map<String, String> headers = {'Authorization': 'Bearer ' + token!};
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      setData(res);
      _statusCode = response.statusCode;
    } else {
      print("************");
      print(response.statusCode);
      print("*************");
      _statusCode = response.statusCode;
    }
  }
}
