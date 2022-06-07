import 'package:flutter/material.dart';

///Emailのバリデーションを行うクラス
class EmailValidation {
  bool emailValidation(String email) {
    // バリデーションチェック
    // 正規表現にemailがマッチしたらtrueを返す
    if (RegExp(
            //r"/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/)")
            r"^[a-zA-Z0-9_+-]+(.[a-zA-Z0-9_+-]+)*@([a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]*\.)+[a-zA-Z]{2,}$")
        .hasMatch(email)) {
      // メールの形式が正しい時の処理

      return true;
    } else {
      return false;
    }
  }
}
