import 'package:flutter/material.dart';
import 'package:flutter_instagram/widgets/camera/photo_view.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "새게시물",
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "다음",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: PhotoView(),
    );
  }
}
