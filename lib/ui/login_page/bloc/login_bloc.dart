import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../repository/authentication_repository.dart';
import '../../../validation/password_validation.dart';
import '../../../validation/user_name_validation.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
}): _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUserNameChange>(_onUsernameChanged);
    on<LoginPasswordChange>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }
  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
      LoginUserNameChange event,
      Emitter<LoginState> emit,
      ) {
    final username = Username.dirty(event.userName);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([state.password, username]),
      ),
    );
  }

  void _onPasswordChanged(
      LoginPasswordChange event,
      Emitter<LoginState> emit,
      ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.username]),
      ),
    );
  }

  Future<void> _onSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await _authenticationRepository.logIn(
          username: state.username.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}



