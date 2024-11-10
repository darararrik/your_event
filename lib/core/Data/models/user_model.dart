import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class UserEntity {
  final String email;
  final String name;
  final String surname;

  UserEntity({
    required this.email,
    required this.name,
    required this.surname,
  });

}
