import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_project/main.dart';
import 'package:new_project/models/users_model.dart';
import 'package:new_project/provider/service_provider.dart';
import 'package:new_project/services/getUsersApi.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
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
                return buildUsers(snapshot.data);
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

  buildUsers(List<Users?>? users) {
    return ListView.builder(
        itemCount: users!.length,
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
                Text("Name : ${users[index]!.name}"),
                SizedBox(
                  height: 10,
                ),
                Text("Email : ${users[index]!.email}"),
                SizedBox(
                  height: 10,
                ),
                Text("Phone : ${users[index]!.phone}"),
                SizedBox(
                  height: 10,
                ),
                Consumer<LikeProvider>(
                    builder: (context, likeProviderInstance, _) {
                  return Visibility(
                    visible: likeProviderInstance.checkLike(users[index]!.id!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<LikeProvider>(context, listen: false)
                                .updateLikeEvent(users[index]!.id!);
                          },
                          child: Container(
                            child: Icon(
                              Icons.thumb_up_alt_rounded,
                              color: Colors.indigo,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
                Consumer<LikeProvider>(
                    builder: (context, likeProviderInstance, _) {
                  return Visibility(
                    visible:
                        likeProviderInstance.checkDisLike(users[index]!.id!),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Provider.of<LikeProvider>(context, listen: false)
                                .updateDisLikeEvent(users[index]!.id!);
                          },
                          child: Container(
                            child: Icon(
                              Icons.thumb_down_alt_rounded,
                              color: Colors.indigo,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
              ],
            ),
          );
        });
  }
}
