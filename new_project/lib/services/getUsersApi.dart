import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:new_project/models/users_model.dart';

class GetUsersApi {
  Dio _dio = Dio();
  final baseUrl = "https://jsonplaceholder.typicode.com/users";

  Future<List<Users>> getUserDetails() async {
    List<Users> users = [];

    try {
      Response response = await _dio.get(baseUrl);
      List<dynamic> usersResponse = response.data;
      usersResponse.forEach((element) {
        users.add(Users.fromJson(element));
      });
      print(users);
    } on DioError catch (e) {
      print(e.message);
    }

    return users;
  }
}
