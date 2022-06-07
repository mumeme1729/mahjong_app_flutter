import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahjong_app_flutter/Screens/Login/login_screen.dart';
import 'package:mahjong_app_flutter/models/auth_model/user_register_model.dart';
import 'package:mahjong_app_flutter/screens/signup/components/email_verification_body.dart';

final countProvider = StateProvider((ref) => 0);

class EmailPasswordSignUp extends HookConsumerWidget {
  EmailPasswordSignUp({Key? key}) : super(key: key);

  // テキストコントローラー
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController varifyPasswordController =
      TextEditingController();
  // インスタンス
  final UserRegisterModel userRegisterModel = UserRegisterModel();
  // プロバイダー
  final passwordDisplayProvider = StateProvider((ref) => true);
  final errorTextProvider = StateProvider((ref) => "");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordDisplay = ref.watch(passwordDisplayProvider);
    final errorText = ref.watch(errorTextProvider);
    var _mediaQueryData = MediaQuery.of(context);
    double _screenHeight = _mediaQueryData.size.height;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView(
        child: Container(
          height: _screenHeight,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/top.jpg'),
            fit: BoxFit.cover,
          )),
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _sizeBox(10),
              _textWidget(ref),
              // メールアドレス
              _emailForm(),
              // パスワード
              _passwordFrom(ref),
              // パスワード確認
              _confirmPasswordForm(ref),
              _sizeBox(10),
              _signUPButton(context, ref),
              _sizeBox(15),
              _signupLoginButton(context),
              _sizeBox(MediaQuery.of(context).viewInsets.bottom)
            ],
          ),
        ),
      ),
    );
  }

  //サイズ調節用Box
  Widget _sizeBox(double size) {
    return SizedBox(
      height: size,
    );
  }

  Widget _textWidget(WidgetRef ref) {
    return Text(
      ref.watch(errorTextProvider.notifier).state,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.red,
      ),
    );
  }

  // email入力用フォーム
  Widget _emailForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // 枠線
        border: Border.all(color: Colors.green, width: 2),
        // 角丸
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: emailController,
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.mail),
          hintText: "ログインID",
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  // パスワード入力用フォーム
  Widget _passwordFrom(WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        // 枠線
        border: Border.all(color: Colors.green, width: 2),
        // 角丸
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        obscureText: ref.watch(passwordDisplayProvider.notifier).state,
        controller: passwordController,
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 2.0,
              ),
            ),
            hintText: "パスワード(6文字以上)",
            suffixIcon: IconButton(
              icon: FaIcon(ref.watch(passwordDisplayProvider.notifier).state
                  ? FontAwesomeIcons.solidEyeSlash
                  : FontAwesomeIcons.solidEye),
              onPressed: () {
                ref.watch(passwordDisplayProvider.notifier).state =
                    !ref.watch(passwordDisplayProvider.notifier).state;
              },
            )),
      ),
    );
  }

  // パスワード確認用フォーム
  Widget _confirmPasswordForm(WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        // 枠線
        border: Border.all(color: Colors.green, width: 2),
        // 角丸
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        obscureText: ref.watch(passwordDisplayProvider.notifier).state,
        controller: varifyPasswordController,
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 2.0,
              ),
            ),
            hintText: "確認用パスワード",
            suffixIcon: IconButton(
              icon: FaIcon(ref.watch(passwordDisplayProvider.notifier).state
                  ? FontAwesomeIcons.solidEyeSlash
                  : FontAwesomeIcons.solidEye),
              onPressed: () {
                ref.watch(passwordDisplayProvider.notifier).state =
                    !ref.watch(passwordDisplayProvider.notifier).state;
              },
            )),
      ),
    );
  }

  // サインアップボタン
  Widget _signUPButton(context, WidgetRef ref) {
    return ElevatedButton(
      child: const Text(
        'サインアップ',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      onPressed: () {
        // パスワードが確認用と一致しているか確認を行う
        if (passwordController.text == varifyPasswordController.text) {
          signUp(ref).then((value) => {
                if (value)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EmailVerificationBody()),
                    )
                  }
              });
        } else {
          ref.watch(errorTextProvider.notifier).state = 'パスワードが一致しません';
          passwordController.text = "";
          varifyPasswordController.text = "";
        }
      },
    );
  }

  Widget _signupLoginButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "アカウントをお持ち方    ",
          style: TextStyle(color: Colors.amber),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Log In",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  // サインアップ処理
  Future<bool> signUp(WidgetRef ref) async {
    String? email = emailController.text;
    String? password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      // firebase authでユーザーを作成する
      try {
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // ユーザーを取得
        final user = userCredential.user;
        if (user != null) {
          print(user.uid);
          // 確認用メールを送信
          user.sendEmailVerification();
          // サーバー側にデータを送信
          userRegisterModel.postUserData(user.uid, true);
          // メール確認画面に遷移
          return true;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ref.watch(errorTextProvider.notifier).state = '指定したメールアドレスは登録済みです';
        } else if (e.code == 'invalid-email') {
          ref.watch(errorTextProvider.notifier).state =
              'メールアドレスのフォーマットが正しくありません';
        } else if (e.code == 'operation-not-allowed') {
          ref.watch(errorTextProvider.notifier).state =
              '指定したメールアドレス・パスワードは現在使用できません';
        } else if (e.code == 'weak-password') {
          ref.watch(errorTextProvider.notifier).state = 'パスワードは6文字以上にしてください';
        }
        passwordController.text = "";
        varifyPasswordController.text = "";
        emailController.text = "";
        return false;
      }
    }
    return false;
  }
}
