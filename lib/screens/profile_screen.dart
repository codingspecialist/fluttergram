import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';
import 'package:flutter_instagram/widgets/rounded_avatar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _appbar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(common_gap),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/background.jpeg"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: common_gap),
                        child: Table(
                          children: [
                            TableRow(children: [
                              _valueText("123123"),
                              _valueText("123123"),
                              _valueText("123123"),
                            ]),
                            TableRow(children: [
                              _labelText("Post"),
                              _labelText("Followers"),
                              _labelText("Following"),
                            ]),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                _username(),
                _bio(),
                _editProfileButton(),
                _tabButtons(),
              ]),
            )
          ];
        },
        body: TabBarView(controller: _tabController, children: [
          GridView.builder(
            shrinkWrap: true,
            itemCount: 20,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) =>
                Image.network("https://picsum.photos/id/${index + 1}/200/200"),
          ),
          Container(
            color: Colors.red,
          )
        ]),
      ),
    );
  }

  Text _valueText(String value) {
    return Text(
      value,
      style: TextStyle(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Text _labelText(String label) {
    return Text(
      label,
      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11.0),
      textAlign: TextAlign.center,
    );
  }

  TabBar _tabButtons() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.black,
      tabs: [
        Tab(
          icon: Icon(Icons.apps),
        ),
        Tab(
          icon: Icon(Icons.account_box_outlined),
        ),
      ],
    );
  }

  Padding _editProfileButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Padding _bio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text("i like banana!"),
    );
  }

  Padding _username() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text("username", style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  AppBar _appbar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {},
      ),
      title: Text("cos"),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_horiz,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
