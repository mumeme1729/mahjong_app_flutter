import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahjong_app_flutter/Screens/home/home_screen.dart';
import 'package:mahjong_app_flutter/components/email_validation.dart';
import 'package:mahjong_app_flutter/models/auth_model/token_model.dart';
import 'package:mahjong_app_flutter/screens/signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

final countProvider = StateProvider((ref) => 0);

class EmailPasswordLogInBody extends HookConsumerWidget {
  EmailPasswordLogInBody({Key? key}) : super(key: key);
  // テキストコントローラー
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final EmailValidation _emailValidation = EmailValidation();
  // インスタンス
  final AuthTokenModel _authToken = AuthTokenModel();
  // プロバイダー
  final loginErrorProvider = StateProvider((ref) => "");
  final passwordDisplay = useState(true);
  final isEmalValid = useState(true);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final cnt = ref.watch(countProvider.notifier);
    final errorText = ref.watch(loginErrorProvider);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/top.jpg'),
          fit: BoxFit.cover,
        )),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ログインID
            Container(
              child: isEmalValid.value
                  ? const Text("")
                  : const Text("フォーマットが一致しません"),
            ),
            _sizeBox(10),
            _textWidget(ref),
            // ログインフォーム
            _loginForm(),
            // パスワードフォーム
            _passwordForm(),
            _sizeBox(10),
            // ログインボタン
            _loginButton(context, ref),
            // signup login changeボタン
            _signupLoginButton(context)
          ],
        ),
      ),
    );
  }

  //サイズ調節用Box
  Widget _sizeBox(double x) {
    return SizedBox(
      height: x,
    );
  }

  Widget _textWidget(WidgetRef ref) {
    return Text(
      ref.watch(loginErrorProvider.notifier).state,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.red,
      ),
    );
  }

  // ログインフォーム
  Widget _loginForm() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: _emailController,
        onSaved: (value) {
          _emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.mail),
            hintText: "ログインID",
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15)),
      ),
    );
  }

  //パスワードフォーム
  Widget _passwordForm() {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        // 枠線
        border: Border.all(color: Colors.grey, width: 2),
        // 角丸
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        obscureText: passwordDisplay.value,
        controller: _passwordController,
        onSaved: (value) {
          _emailController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            prefixIcon: const Icon(Icons.password),
            hintText: "パスワード",
            suffixIcon: IconButton(
              icon: FaIcon(passwordDisplay.value
                  ? FontAwesomeIcons.solidEyeSlash
                  : FontAwesomeIcons.solidEye),
              onPressed: () {
                passwordDisplay.value = !passwordDisplay.value;
              },
            )),
      ),
    );
  }

  // ログインボタン
  Widget _loginButton(context, ref) {
    return ElevatedButton(
        child: const Text(
          'ログイン',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        onPressed: () {
          checkValidation(context, ref);
        });
  }

  // sign uo ←→ login チェンジボタン
  Widget _signupLoginButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "アカウントをお持ちでない場合",
          style: TextStyle(color: Colors.amber),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUP()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  //入力時のチェックとトークンの取得
  void checkValidation(context, ref) async {
    // emailが正しい時
    try {
      isEmalValid.value = true;
      //アクセストークンの取得
      final loginUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final user = loginUser.user;
      if (user != null) {
        print(user.uid);
        print(user.emailVerified);
        user.getIdToken().then((value) => _authToken.setAccessKey(value));
        user.getIdToken().then((value) => print(value));
        // TODO このアカウントが有効かどうか、認証が済んでいくか確認を行う
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Home()));

      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ref.watch(loginErrorProvider.notifier).state = 'ユーザーが見つかりませんでした。';
      } else if (e.code == 'invalid-email') {
        ref.watch(loginErrorProvider.notifier).state =
            'メールアドレスのフォーマットが正しくありません';
      } else if (e.code == 'operation-not-allowed') {
        ref.watch(loginErrorProvider.notifier).state =
            '指定したメールアドレス・パスワードは現在使用できません';
      } else if (e.code == 'weak-password') {
        ref.watch(loginErrorProvider.notifier).state = 'パスワードは6文字以上にしてください';
      }
    }
    // _authToken
    //     .getAccessToken(_emailController.text, _passwordController.text)
    //     .then((value) => {
    //           if (value == 200)
    //             {
    //               _authToken.readAccessKey().then((value) => {
    //                     if (value != null)
    //                       {
    //                         //アクセストークンが取得できた場合Homeスクリーンに移動
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (context) => Home()))
    //                       }
    //                   })
    //             }
    //         });
  }
}
