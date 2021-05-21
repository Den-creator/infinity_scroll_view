import 'dart:convert';

import '../data_provider/go_rest_api.dart';
import '../model/user.dart';

class UsersRepository {
  final _api = GoRestAPI();

  Future<List<User>> getUsers({required int page}) async {
    try {
      final usersJson = await _api.getUsersJsonString(page);
      final List listOfUsers = JsonDecoder().convert(usersJson)['data'];

      return listOfUsers.map((e) => User.fromMap(e)).toList();
    } catch (e) {
      throw e;
    }
  }
}
