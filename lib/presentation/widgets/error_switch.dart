import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/users_cubit.dart';
import '../../constants.dart';

class ErrorSwitch extends StatefulWidget {
  const ErrorSwitch({Key? key}) : super(key: key);

  @override
  _ErrorSwitchState createState() => _ErrorSwitchState();
}

class _ErrorSwitchState extends State<ErrorSwitch> {
  var _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          const Text('Error', style: TextStyle(fontSize: 15)),
          Switch(
            value: _switchValue,
            activeColor: k.pinkColor,
            onChanged: (newValue) {
              k.error = newValue;
              setState(() {
                _switchValue = newValue;
              });

              if (newValue == false) context.read<UsersCubit>().refreshUsers();
            },
          )
        ],
      ),
    );
  }
}
