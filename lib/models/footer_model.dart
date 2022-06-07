import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mahjong_app_flutter/Screens/home/components/home.dart';
import 'package:mahjong_app_flutter/screens/home/components/groups.dart';
import 'package:mahjong_app_flutter/screens/home/components/other.dart';
import 'package:mahjong_app_flutter/screens/home/components/record.dart';

final footerModel = ChangeNotifierProvider((_) => FooterModel());

class FooterModel extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selecttedIndex => _selectedIndex;
  List<Widget> get pageList => _pageList;
  final List<Widget> _pageList = [
    HomeBody(),
    Groups(),
    const Record(),
    const Other()
    // MyHomePage(),
    // Learn(),
  ];

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
