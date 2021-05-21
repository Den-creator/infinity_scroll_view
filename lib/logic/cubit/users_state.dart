part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  final List<User> users;
  final bool noMoreData; // help to check if we need load new data on scroll

  const UsersState(this.users, [this.noMoreData = false]);

  @override
  List<Object?> get props => [users, noMoreData];
}

class UsersInitial extends UsersState {
  const UsersInitial(List<User> users) : super(users);
}

class UsersIsLoading extends UsersState {
  const UsersIsLoading(List<User> users) : super(users);
}

class UsersLoaded extends UsersState {
  const UsersLoaded(
    List<User> users, {
    bool noMoreData = false,
  }) : super(users, noMoreData);
}

class UsersFetchError extends UsersState {
  const UsersFetchError(List<User> users) : super(users);

  @override
  String toString() {
    return 'Something went wrong ...';
  }
}
