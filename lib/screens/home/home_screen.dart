import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mahjong_app_flutter/screens/home/components/footer.dart';

import 'components/home.dart';

final countProvider = StateProvider((ref) => 0);

class Home extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Footer(),
    );
  }
}
