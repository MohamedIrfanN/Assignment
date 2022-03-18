import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_project/provider/service_provider.dart';
import 'package:new_project/screens/homepage/view/homepageview.dart';
import 'package:new_project/screens/profile/view/profile.dart';
import 'package:provider/provider.dart';

// final box = Hive.box('Likes');

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('Likes');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // int counter = box.get('like') ?? 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LikeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePageView(),
      ),
    );
  }
}
