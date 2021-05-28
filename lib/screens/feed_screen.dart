import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/src/flutterwork/flutter_instagram/lib/widgets/feed/post.dart';

class FeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(CupertinoIcons.camera),
        title: Text(
          "instagram",
          style: TextStyle(fontFamily: "VeganStyle", color: Colors.black87),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.camera),
            onPressed: () {
              print("클릭");
            },
          ),
          IconButton(
            icon: Icon(CupertinoIcons.camera),
            onPressed: () {
              print("클릭");
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: feedListBuilder,
        itemCount: 30,
      ),
    );
  }

  Widget feedListBuilder(context, index) {
    return Post(index);
  }
}
