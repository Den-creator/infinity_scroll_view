import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/users_cubit.dart';
import '../../presentation/widgets/users_list_view.dart';
import '../widgets/error_switch.dart';
import '../widgets/add_new_user_sheet.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UsersCubit>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: Platform.isIOS,
        title: const Text('Infinity List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh list',
            onPressed: () => cubit.refreshUsers(),
          ),
          ErrorSwitch(),
          const SizedBox(width: 10)
        ],
      ),
      body: UsersListView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: cubit,
                child: AddNewUserSheet(),
              );
            },
          );
        },
      ),
    );
  }
}
