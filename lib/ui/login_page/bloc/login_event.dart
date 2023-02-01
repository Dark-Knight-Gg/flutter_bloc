import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// class CheckLogin extends LoginEvent {
//   CheckLogin({
//     required this.email,
//     required this.password,
//   });
//
//   final String email;
//   final String password;
//   @override
//   List<Object?> get props => [email,password];
// }
class LoginUserNameChange extends LoginEvent{
  LoginUserNameChange(this.userName);
  final String userName;
  @override
  List<Object> get props => [userName];
}
class LoginPasswordChange extends LoginEvent{
  LoginPasswordChange(this.password);
  final String password;
  @override
  List<Object> get props => [password];
}
class LoginSubmitted extends LoginEvent {
  LoginSubmitted();
}
