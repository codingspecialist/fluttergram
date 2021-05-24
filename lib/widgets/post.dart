import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/widgets/comment.dart';
import 'package:flutter_instagram/widgets/rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index;

  const Post(
    this.index, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Widget _postCaption() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: Comment(
        showImage: true,
        username: "ssarmango",
        text: "Today is very Good",
      ),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        "12000 likes",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postActions() {
    return Row(
      children: [
        IconButton(
          icon: ImageIcon(AssetImage("assets/images/bookmark.png")),
          color: Colors.black87,
          onPressed: () {},
        ),
        IconButton(
          icon: ImageIcon(AssetImage("assets/images/comment.png")),
          color: Colors.black87,
          onPressed: () {},
        ),
        IconButton(
          icon: ImageIcon(AssetImage("assets/images/direct_message.png")),
          color: Colors.black87,
          onPressed: () {},
        ),
        Spacer(),
        IconButton(
          icon: ImageIcon(AssetImage("assets/images/heart_selected.png")),
          color: Colors.black87,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _postHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ),
        Expanded(child: Text("username")),
        IconButton(
          icon: Icon(Icons.more_horiz),
          color: Colors.black87,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _postImage() {
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: CachedNetworkImage(
        imageUrl: "https://picsum.photos/id/$index/200/200",
        placeholder: (context, url) {
          return Center(
            child: CircularProgressIndicator(backgroundColor: Colors.black87),
          );
        },
        fit: BoxFit.cover,
      ),
    );
  }
}
