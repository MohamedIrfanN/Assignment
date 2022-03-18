import 'package:flutter/material.dart';
import 'package:new_project/provider/service_provider.dart';
import 'package:new_project/screens/liked/view/likedview.dart';
import 'package:new_project/screens/profile/view/profile.dart';
import 'package:provider/provider.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<LikeProvider>(
              builder: (context, likeProviderInstance, _) {
            return Text("Likes  ${likeProviderInstance.getLike()}");
          }),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Home",
              ),
              Tab(
                text: "Liked",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Profile(),
            LikedView(),
          ],
        ),
      ),
    );
  }
}
