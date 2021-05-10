import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repository/users_repository.dart';
import '../../data/models/user.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  static const _itemsPerPage = 20; // server configuration
  final _repository = UsersRepository();

  UsersCubit() : super(UsersInitial([]));

  void getUsers() async {
    if (state is UsersIsLoading ||
        state is UsersFetchError ||
        state.noMoreData) {
      return;
    }

    emit(UsersIsLoading(state.users));

    try {
      final page = state.users.length / _itemsPerPage + 1;
      final users = await _repository.getUsers(page: page.toInt());

      emit(UsersLoaded(
        state.users + users,
        haveNoMoreData: users.isEmpty,
      ));
    } catch (_) {
      emit(UsersFetchError(state.users));
    }
  }

  void refreshUsers() {
    emit(UsersInitial([]));
    getUsers();
  }

  void addNewUser(User user) {
    final List<User> updatedUsers = List.from(state.users)..insert(0, user);
    emit(UsersLoaded(updatedUsers));
  }
}
