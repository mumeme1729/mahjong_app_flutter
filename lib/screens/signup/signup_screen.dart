import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mahjong_app_flutter/screens/signup/components/email_password_signup.dart';
import 'package:mahjong_app_flutter/screens/signup/components/signup_body.dart';

// import 'components/signup_body.dart';

final countProvider = StateProvider((ref) => 0);

class SignUP extends HookConsumerWidget {
  const SignUP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SignUpBody(),
    );
  }
}
