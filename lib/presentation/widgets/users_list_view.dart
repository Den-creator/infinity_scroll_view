import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/users_cubit.dart';
import 'user_list_tile.dart';
import 'footer_spinner.dart';

class UsersListView extends StatefulWidget {
  const UsersListView();

  @override
  _UsersListViewState createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  final _scrollController = ScrollController();
  late UsersCubit _cubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _cubit = context.read<UsersCubit>();
    _cubit.getUsers();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _cubit.getUsers();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      builder: (_, state) {
        if (state.users.isEmpty) {
          if (state is UsersIsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return const Center(child: Text('No data to show'));
        }

        return ListView.builder(
            controller: _scrollController,
            itemCount: (state.noMoreData || state is UsersFetchError)
                ? state.users.length
                : state.users.length + 1,
            itemBuilder: (_, index) {
              if (index >= state.users.length) {
                return const FooterSpinner();
              }

              return UserListTile(user: state.users[index]);
            });
      },
      listener: (ctx, state) {
        if (state is UsersFetchError)
          showDialog(
            context: ctx,
            builder: (_) => AlertDialog(
              title: const Text('Error'),
              content: Text(state.toString()),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          );
      },
    );
  }
}
