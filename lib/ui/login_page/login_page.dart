import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vti_express/ui/login_page/bloc/login_event.dart';

import '../../common/build_widget.dart';
import '../../repository/authentication_repository.dart';
import '../change_company/change_company_page.dart';
import '../forgot_password/forgot_password_bottom_sheet.dart';
import '../home_page/home_page.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
            );
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}

Padding _buildImageLogo(String s) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(110, 50, 110, 50),
    child: Image.asset(s),
  );
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          }
        },
        builder: (context, state) => const _BuildForm());
  }
}

class _BuildForm extends StatefulWidget {
  const _BuildForm({Key? key}) : super(key: key);

  @override
  State<_BuildForm> createState() => _BuildFormState();
}

class _BuildFormState extends State<_BuildForm> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  late bool isActive;

  @override
  void initState() {
    isActive = true;
    userNameController.addListener(() {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(userNameController.text)) {
        passwordController.addListener(() {
          if (passwordController.text.length >= 7) {
            setState(() {
              isActive = false;
            });
          } else {
            setState(() {
              isActive = true;
            });
          }
        });
      } else {
        setState(() {
          isActive = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 100, 15, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildImageLogo('assets/images/logo.png'),
              BuildUserNameTextField(userNameController: userNameController),

              BuildPasswordTextField(passwordController: passwordController),
              CustomTextButton(
                  text: 'Quên mật khẩu',
                  builder: const ForgotPasswordBottomSheet()),
              BuildLoginButton(isActive: isActive),
              Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height / 3.5,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ChangeCompanyPage()),
                        (route) => false);
                  },
                  child: Text(
                    'Thay đổi công ty?',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                            fontSize: 14, color: Colors.blueAccent)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BuildUserNameTextField extends StatefulWidget {
  final userNameController = TextEditingController();

  BuildUserNameTextField({required userNameController, Key? key})
      : super(key: key);

  @override
  State<BuildUserNameTextField> createState() => _BuildUserNameTextFieldState();
}

class _BuildUserNameTextFieldState extends State<BuildUserNameTextField> {
  final userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CustomTextFieldHaveIcon(
          text: 'Nhập tên đăng nhập...',
          visible: false,
          controller: userNameController,
          suffixIcon: true,
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUserNameChange(username)),
          errorText: state.username.invalid ? 'invalid username' : null,
        );
      },
    );
  }
}

class BuildLoginButton extends StatefulWidget {
  final bool isActive;

  const BuildLoginButton({required this.isActive, Key? key}) : super(key: key);

  @override
  State<BuildLoginButton> createState() => _BuildLoginButtonState();
}

class _BuildLoginButtonState extends State<BuildLoginButton> {
  // final bool isActive= false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomButton(
            text: 'Đăng nhập',
            isActive: widget.isActive,
            onPressed: state.status.isValidated
                ? () {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                : null);
      },
    );
  }
}

class BuildPasswordTextField extends StatefulWidget {
  final TextEditingController passwordController;

  const BuildPasswordTextField({required this.passwordController, Key? key})
      : super(key: key);

  @override
  State<BuildPasswordTextField> createState() => _BuildPasswordTextFieldState();
}

class _BuildPasswordTextFieldState extends State<BuildPasswordTextField> {
  late bool _suffixIcon;
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    _suffixIcon = true;
    widget.passwordController.addListener(() {
      if (widget.passwordController.text.isNotEmpty) {
        setState(() {
          _suffixIcon = false;
        });
      } else {
        setState(() {
          _suffixIcon = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextFieldHaveIcon(
          text: 'Nhập mật khẩu...',
          visible: _passwordVisible,
          controller: widget.passwordController,
          suffixIcon: _suffixIcon,
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChange(password)),
          errorText: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }
}

Widget buildLoginLoading() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUserNameChange(username)),
          decoration: InputDecoration(
            labelText: 'username',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChange(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          key: const Key('loginForm_continue_raisedButton'),
          onPressed: state.status.isValidated
              ? () {
            context.read<LoginBloc>().add(LoginSubmitted());
          }
              : null,
          child: const Text('Login'),
        );
      },
    );
  }
}
