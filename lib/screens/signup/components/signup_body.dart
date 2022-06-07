import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahjong_app_flutter/Screens/Login/login_screen.dart';
import 'package:mahjong_app_flutter/screens/signup/components/email_password_signup.dart';
import 'package:mahjong_app_flutter/screens/signup/components/email_verification_body.dart';

final countProvider = StateProvider((ref) => 0);

class SignUpBody extends HookConsumerWidget {
  SignUpBody({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController varifyPasswordController =
      TextEditingController();
  final passwordDisplay = useState(true);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final cnt = ref.watch(countProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.blue[50],
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      // ),
      //drawer: BarDrawer(),
      body: Center(
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/top.jpg'),
            fit: BoxFit.cover,
          )),
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // メールアドレス・パスワードログイン
              _emailPasswordLogin(context),
              _sizeBox(10),
              // Googleログイン
              _googleLogin(context),
              _sizeBox(10),
              // Twitterログイン
              _twitterLogin(),
              _sizeBox(10),
              _sizeBox(20),
              _signupLoginButton(context)
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

  // emailログイン
  Widget _emailPasswordLogin(context) {
    return SignInButton(
      Buttons.Email,
      text: "Sign up with Email",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmailPasswordSignUp()),
        );
      },
    );
  }

  // Googleログイン
  Widget _googleLogin(context) {
    return SignInButton(
      Buttons.Google,
      text: "Sign up with Google",
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const EmailVerificationBody()),
        );
      },
    );
  }

  // Twitterログイン
  Widget _twitterLogin() {
    return SignInButton(
      Buttons.Twitter,
      text: "Sign up with Twitter",
      onPressed: () {},
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
            "サインイン",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
