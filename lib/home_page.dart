import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/screen_num.dart';
import 'package:flutter_instagram/constants/screen_size.dart';
import 'package:flutter_instagram/screens/feed_screen.dart';
import 'package:flutter_instagram/screens/profile_screen.dart';
import 'package:flutter_instagram/screens/search_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.add), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.healing), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: ""),
  ];

  int _selectedIndex = 0;

  List<Widget> _screens = [
    FeedScreen(), // ctrl + d
    SearchScreen(),
    SizedBox(),
    Container(
      color: Colors.deepPurpleAccent,
    ),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        items: btmNavItems,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black87,
        currentIndex: _selectedIndex,
        onTap: _onBtmItemClick,
      ),
    );
  }

  void _onBtmItemClick(int index) {
    if (index == ScreenNum.camera.index) {
      _startCamera();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _startCamera() async {
    if (await confirmPermissionGranted(context)) {
      Navigator.of(context).pushNamed("/camera");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("사진, 파일, 마이크 접근을 허용 해주셔야 카메라 사용이 가능합니다."),
        action: SnackBarAction(
          label: "OK",
          onPressed: () {
            AppSettings.openAppSettings();
          },
        ),
      ));
    }
  }

  Future<bool> confirmPermissionGranted(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.camera].request();
    bool permitted = true;

    statuses.forEach((key, value) {
      if (!value.isGranted) {
        permitted = false;
      }
    });
    return permitted;
  }
}
