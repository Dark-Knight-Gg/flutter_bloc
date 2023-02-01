import '../models/user.dart';
import 'dart:async';
class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
          () => _user = null,
    );
  }
}