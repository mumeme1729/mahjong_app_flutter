import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mahjong_app_flutter/models/login_user_model/login_user_data_view_model.dart';
import 'package:mahjong_app_flutter/models/login_user_model/user_data_model.dart';
import 'package:mahjong_app_flutter/screens/login/login_screen.dart';

class HomeBody extends HookConsumerWidget {
  HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginUserData = ref.watch(loginUserViewModel);

    useEffect(() {
      print("**** useEffect *****");
      loginUserData.getLoginUserData();
    }, [loginUserData]);

    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
          // HTTPレスポンス200以外はログインページへ
          if (loginUserData.getStatusCode() == 200) {
            return Column(
              children: [
                _loginUserImage(loginUserData),
                _rankTable(loginUserData),
                _recordTable(loginUserData)
              ],
            );
          } else if (loginUserData.getStatusCode() == 0) {
            return const Text("読み込み中...");
          } else {
            return LogIn();
          }
        }));
  }

  // ユーザーのアバターを表示
  Widget _loginUserImage(loginUserData) {
    if (loginUserData.loginUserData.image != "" &&
        loginUserData.loginUserData.image != null) {
      return CircleAvatar(backgroundImage: (loginUserData.loginUserData.image));
    } else {
      return const CircleAvatar(
          backgroundImage: AssetImage('images/default_avatar.jpg'));
    }
  }

  // 順位テーブル
  Widget _rankTable(loginUserData) {
    return SizedBox(
        width: double.infinity,
        child: FittedBox(
            child: DataTable(
          columns: const [
            DataColumn(
              label: Text('1位'),
            ),
            DataColumn(
              label: Text('2位'),
            ),
            DataColumn(
              label: Text('3位'),
            ),
            DataColumn(
              label: Text('4位'),
            ),
            DataColumn(
                label: Text(
              '平均順位',
            )),
            DataColumn(
              label: Text('総対局数'),
            ),
          ],
          rows: [
            loginUserData == null
                ? const DataRow(
                    cells: [
                      DataCell(Center(child: Text('0'))),
                      DataCell(Center(child: Text('0'))),
                      DataCell(Center(child: Text('0'))),
                      DataCell(Center(child: Text('0'))),
                      DataCell(Center(child: Text('0'))),
                      DataCell(Center(child: Text('0'))),
                    ],
                  )
                : DataRow(
                    cells: [
                      DataCell(Center(
                          child: Text(
                              loginUserData.loginUserData.rank1.toString()))),
                      DataCell(Center(
                          child: Text(
                              loginUserData.loginUserData.rank2.toString()))),
                      DataCell(Center(
                          child: Text(
                              loginUserData.loginUserData.rank3.toString()))),
                      DataCell(Center(
                          child: Text(
                              loginUserData.loginUserData.rank4.toString()))),
                      DataCell(Center(
                          child: Text((((loginUserData.loginUserData.rank1) *
                                          1 +
                                      (loginUserData.loginUserData.rank2) * 2 +
                                      (loginUserData.loginUserData.rank3) * 3 +
                                      (loginUserData.loginUserData.rank4) * 4) /
                                  loginUserData.loginUserData.gameCnt)
                              .toString()))),
                      DataCell(Center(
                          child: Text(
                              loginUserData.loginUserData.gameCnt.toString()))),
                    ],
                  )
          ],
        )));
  }

  // 順位テーブル
  Widget _recordTable(loginUserData) {
    return SizedBox(
        width: double.infinity,
        child: FittedBox(
            child: DataTable(
          columns: const [
            DataColumn(
              label: Text('合計スコア'),
            ),
            DataColumn(
              label: Text('平均スコア'),
            ),
            DataColumn(
              label: Text('トップ率'),
            ),
            DataColumn(
              label: Text('ラス率'),
            ),
            DataColumn(
                label: Expanded(
                    child: Text(
              '連対率',
            ))),
          ],
          rows: [
            loginUserData == null
                ? const DataRow(
                    cells: [
                      DataCell(Center(child: Text('0'))),
                      DataCell(Center(child: Text('0'))),
                      DataCell(Center(child: Text('0'))),
                      DataCell(Center(child: Text('0'))),
                      DataCell(Center(child: Text('0'))),
                    ],
                  )
                : DataRow(
                    cells: [
                      DataCell(Center(
                          child: Text(
                              loginUserData.loginUserData.score.toString()))),
                      DataCell(Center(
                          child: Text((loginUserData.loginUserData.score /
                                  loginUserData.loginUserData.gameCnt)
                              .toString()))),
                      DataCell(Center(
                          child: Text(
                              loginUserData.loginUserData.rank3.toString()))),
                      DataCell(Center(
                          child: Text(
                              loginUserData.loginUserData.rank4.toString()))),
                      DataCell(Center(
                          child: Text((((loginUserData.loginUserData.rank1) *
                                          1 +
                                      (loginUserData.loginUserData.rank2) * 2 +
                                      (loginUserData.loginUserData.rank3) * 3 +
                                      (loginUserData.loginUserData.rank4) * 4) /
                                  loginUserData.loginUserData.gameCnt)
                              .toString()))),
                    ],
                  )
          ],
        )));
  }
} //HomeBody
