import 'package:equatable/equatable.dart';

enum Gender { female, male }

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final Gender gender;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
  });

  @override
  List<Object?> get props => [id, name, email, gender];

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: (map['id'] as int).toString(),
      name: map['name'] as String,
      email: map['email'] as String,
      gender: (map['gender'] as String) == 'Male' ? Gender.male : Gender.female,
    );
  }
}
