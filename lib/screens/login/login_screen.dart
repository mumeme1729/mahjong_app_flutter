import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mahjong_app_flutter/screens/login/components/email_password_login.dart';

final countProvider = StateProvider((ref) => 0);

class LogIn extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: EmailPasswordLogInBody(),
    );
  }
}
