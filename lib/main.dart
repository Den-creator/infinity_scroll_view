import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'infinity_list_observer.dart';
import 'presentation/screens/my_home_page.dart';
import 'logic/cubit/users_cubit.dart';

void main() {
  Bloc.observer = InfinityListObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => UsersCubit(),
        child: MyHomePage(),
      ),
    );
  }
}
