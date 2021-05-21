import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/widgets/gender_checkboxes.dart';
import '../../data/model/user.dart';
import '../../logic/cubit/users_cubit.dart';

// ignore: must_be_immutable
class AddNewUserSheet extends StatelessWidget {
  static const _textStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16);

  var name = '';
  var email = '';
  Gender? selectedGender;

  Widget buildWidget(String title, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: _textStyle,
        ),
        TextField(onChanged: onChanged),
        const SizedBox(height: 20)
      ],
    );
  }

  void addNewUser(BuildContext context) {
    if (name == '' || email == '' || selectedGender == null) {
      return;
    }

    final id = Uuid().v4();
    final user = User(
      id: id,
      name: name,
      email: email,
      gender: selectedGender!,
    );
    context.read<UsersCubit>().addNewUser(user);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildWidget('Name', (value) => name = value),
            buildWidget('Email', (value) => email = value),
            const Text('Gender', style: _textStyle),
            const SizedBox(height: 10),
            GenderCheckboxes((gender) => selectedGender = gender),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Add New User'),
                onPressed: () => addNewUser(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
