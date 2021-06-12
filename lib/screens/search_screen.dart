import 'package:flutter/material.dart';
import 'package:flutter_instagram/widgets/common/custom_follower_button.dart';
import 'package:flutter_instagram/widgets/common/rounded_avatar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<bool> followings = List.generate(30, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                leading: RoundedAvatar(),
                title: Text("username $index"),
                subtitle: Text("user bio number $index"),
                trailing: CustomFollowButton(
                    followingOrFollow: () {
                      setState(() {
                        followings[index] = !followings[index];
                      });
                    },
                    value: followings[index] == true ? "Follow" : "Following"),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: 30));
  }
}
