import 'package:flutter/material.dart';
import 'package:new_project/models/users_model.dart';
import 'package:new_project/provider/service_provider.dart';
import 'package:new_project/services/getUsersApi.dart';
import 'package:provider/provider.dart';

class LikedView extends StatelessWidget {
  Users users = Users();
  GetUsersApi getUser = GetUsersApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<List<Users?>>(
          future: getUser.getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Some Error Ocuured"),
                );
              } else if (snapshot.hasData) {
                return buildUsers(snapshot.data, context);
              }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  buildUsers(List<Users?>? users, BuildContext context) {
    var likedPeople =
        Provider.of<LikeProvider>(context, listen: true).getLikesList();
    var filteredPeople = [];
    for (var i = 0; i < users!.length; i++) {
      for (var j = 0; j < likedPeople.length; j++) {
        if (users[i]!.id == likedPeople[j]) {
          filteredPeople.add(users[i]);
        }
      }
    }
    return ListView.builder(
        itemCount: likedPeople.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                Text("Name : ${filteredPeople[index].name}"),
                SizedBox(
                  height: 10,
                ),
                Text("Email : ${filteredPeople[index].email}"),
                SizedBox(
                  height: 10,
                ),
                Text("Phone : ${filteredPeople[index].phone}"),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}
