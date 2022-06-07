import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mahjong_app_flutter/models/login_user_model/login_user_data_view_model.dart';
import 'package:mahjong_app_flutter/models/login_user_model/user_data_model.dart';

class GroupDetail extends HookConsumerWidget {
  GroupDetail(this.groupData, {Key? key}) : super(key: key);
  var groupData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginUserData = ref.watch(loginUserViewModel);

    return Scaffold(
        backgroundColor: Colors.blue[50], body: _groupDetailColumn());
  }

  // グループページのメインホーム
  Widget _groupDetailColumn() {
    return Column(
      children: <Widget>[
        Hero(
            tag: 'background' + groupData.id,
            child: Image.asset('images/default_avatar.jpg')),
        Container(
          child: Text(groupData.title),
        )
      ],
    );
  }
}
