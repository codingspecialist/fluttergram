import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShardImages extends ChangeNotifier {
  List<String>? picImageNames;

  void setShardImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    picImageNames = prefs.getStringList("picked");
    notifyListeners();
  }
}
