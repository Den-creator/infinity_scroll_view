import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/model/user.dart';
import '../interactor.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final _interactor = Interactor();

  UsersCubit() : super(UsersInitial([]));

  void getUsers() async {
    if (state is UsersIsLoading ||
        state is UsersFetchError ||
        state.noMoreData) {
      return;
    }

    emit(UsersIsLoading(state.users));

    try {
      final users =
          await _interactor.getUsers(currentUsersCount: state.users.length);

      emit(UsersLoaded(
        state.users + users,
        noMoreData: users.isEmpty,
      ));
    } catch (e) {
      print(e);
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
