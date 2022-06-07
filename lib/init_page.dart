import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mahjong_app_flutter/models/auth_model/token_model.dart';
import 'package:mahjong_app_flutter/screens/home/home_screen.dart';

// 初期ページ
// ログイン済みの場合: home そうでない場合: login
class InitPage extends HookConsumerWidget {
  InitPage({Key? key}) : super(key: key);
  User? result = FirebaseAuth.instance.currentUser;
  // インスタンス
  final AuthTokenModel _authToken = AuthTokenModel();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: FutureBuilder(
          future: result!
              .getIdToken()
              .then((value) => _authToken.setAccessKey(value)),
          // アクセスキーを取得
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (result != null) {
              return Home();
            } else {
              return const Text("データが存在しません");
            }
          }),
    );
  }
}
