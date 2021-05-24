import 'package:flutter/material.dart';
import 'package:flutter_instagram/constants/common_size.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

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

  TabBar _tabButtons() {
    return TabBar(
      controller: _tabController,
      indicatorColor: Colors.black,
      tabs: [
        Tab(
          icon: Icon(Icons.directions_car),
        ),
        Tab(
          icon: Icon(Icons.directions_transit),
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
