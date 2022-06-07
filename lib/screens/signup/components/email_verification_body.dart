import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// 登録メール確認用画面
class EmailVerificationBody extends HookConsumerWidget {
  const EmailVerificationBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(40.0),
          child: const Text(
            "ご登録いただいたメールアドレスに確認用のメールを送信いたしました。",
            textAlign: TextAlign.center,
          ),
        ));
  }
}
