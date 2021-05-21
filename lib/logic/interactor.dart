import 'package:infinity_list_view/data/model/user.dart';

import '../data/repository/users_repository.dart';

class Interactor {
  static const _itemsPerPage = 20; // server configuration
  final _repository = UsersRepository();

  Future<List<User>> getUsers({required int currentUsersCount}) async {
    final page = currentUsersCount / _itemsPerPage + 1;
    return _repository.getUsers(page: page.toInt()).catchError((e) => throw e);
  }
}
