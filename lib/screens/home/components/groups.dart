import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mahjong_app_flutter/models/login_user_model/login_user_data_view_model.dart';
import 'package:mahjong_app_flutter/screens/groups/group_detail.dart';

class Groups extends HookConsumerWidget {
  Groups({Key? key}) : super(key: key);
  final hasPaddingProvider = StateProvider((ref) => false);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginUserData = ref.watch(loginUserViewModel);
    final _hasPadding = ref.watch(hasPaddingProvider);
    return Scaffold(
        backgroundColor: Colors.blue[50],
        body: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
          // HTTPレスポンス200以外はログインページへ
          if (loginUserData.getStatusCode() == 200) {
            return _groupTail(loginUserData, ref);
          } else {
            return const Text("読み込み中...");
          }
        }));
  }

  //グループタイル
  Widget _groupTail(loginUserData, ref) {
    return loginUserData != null
        ? ListView.builder(
            itemCount: loginUserData.groupData.length,
            itemBuilder: (BuildContext context, index) {
              return _CardContainer(ref, context, index, loginUserData);
            },
          )
        : const Text('Group');
  }

  Widget _CardContainer(
      WidgetRef ref, BuildContext context, int index, loginUserData) {
    return AnimatedPadding(
        duration: const Duration(milliseconds: 80),
        padding: EdgeInsets.all(
            ref.watch(hasPaddingProvider.notifier).state ? 5 : 0),
        child: GestureDetector(
            onTapDown: (TapDownDetails downDetails) {
              ref.watch(hasPaddingProvider.notifier).state = true;
            },
            onTap: () {
              //タップ処理
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) =>
                        GroupDetail(loginUserData.groupData[index]), //tagを渡す
                  ));
              ref.watch(hasPaddingProvider.notifier).state = false;
            },
            onTapCancel: () {
              ref.watch(hasPaddingProvider.notifier).state = false;
            },
            child: Card(
              child: ListTile(
                leading: Hero(
                    //ここでCustomCardと共通させるTagなどを指定していく
                    tag: 'background' + loginUserData.groupData[index].id,
                    child: Image.asset('images/default_avatar.jpg')),
                title: Text(loginUserData.groupData[index].title),
                subtitle: Text(loginUserData.groupData[index].text),
              ),
            )));
  }
} //HomeBody
