import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LikeProvider extends ChangeNotifier {
  final box = Hive.box('Likes');

  int likeCounter = 0;

  List<int> likedId = [];

  List<int> likedIdCopy = [];

  bool likeVisibility = true;

  int getLike() {
    return box.get('likes') ?? 0;
  }

  List<int> getLikesList() {
    return box.get('likesList') ?? [];
  }

  void updateLikeEvent(int id) async {
    likeCounter = box.get('likes') ?? 0;
    likedId = await box.get('likesList') ?? [];
    likeCounter++;
    likedId.add(id);
    box.put('likesList', likedId);
    box.put('likes', likeCounter);
    notifyListeners();
  }

  void updateDisLikeEvent(int id) async {
    likeCounter = box.get('likes') ?? 0;
    likedId = await box.get('likesList') ?? [];
    likeCounter--;
    likedId.remove(id);
    box.put('likesList', likedId);
    box.put('likes', likeCounter);
    notifyListeners();
  }

  bool checkLike(int id) {
    getDataFromDb();
    return likedIdCopy.contains(id) ? false : true;
  }

  void getDataFromDb() async {
    List<int> checkList = box.get('likesList') ?? [];
    likedIdCopy = checkList;
  }

  bool checkDisLike(int id) {
    getDataFromDb();

    return likedIdCopy.contains(id) ? true : false;
  }
}
