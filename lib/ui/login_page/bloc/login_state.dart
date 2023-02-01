// abstract class LoginState {
//   const LoginState();
// }
//
// class LoginInitial implements LoginState {
//   const LoginInitial();
// }
//
// class LoginLoading implements LoginState {
//   const LoginLoading();
// }
//
// class LoginLoaded implements LoginState {
//   final String messageOk;
//
//   const LoginLoaded(this.messageOk);
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//
//     return other is LoginLoaded && other.messageOk == messageOk;
//   }
//
//   @override
//   int get hashCode => messageOk.hashCode;
// }
//
// class LoginError implements LoginState {
//   final String messageEror;
//   const LoginError(this.messageEror);
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//
//     return other is LoginError && other.messageEror == messageEror;
//   }
//
//   @override
//   int get hashCode => messageEror.hashCode;
// }
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../../validation/password_validation.dart';
import '../../../validation/user_name_validation.dart';


class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });
  final FormzStatus status;
  final Username username;
  final Password password;
  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    bool? isClickIcon,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,

    );
  }

  @override
  List<Object> get props => [status, username, password];

}
