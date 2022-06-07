import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mahjong_app_flutter/models/footer_model.dart';

class Footer extends HookConsumerWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(footerModel).selecttedIndex;
    final pageList = ref.watch(footerModel).pageList;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: IndexedStack(
          index: selectedIndex,
          children: pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed, // これを書かないと3つまでしか表示されない
            items: const [
              BottomNavigationBarItem(label: 'HOME', icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: 'GROUPS', icon: Icon(Icons.group)),
              BottomNavigationBarItem(label: 'RECORD', icon: Icon(Icons.note)),
              BottomNavigationBarItem(label: 'OTHER', icon: Icon(Icons.menu)),
            ],
            currentIndex: selectedIndex,
            onTap: (int index) {
              ref.watch(footerModel).setIndex(index);
            }));
  }
}
