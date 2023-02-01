import 'package:flutter/material.dart ';

import '../../common/build_widget.dart';
import '../login_page/login_page.dart';



class ChangeCompanyPage extends StatefulWidget {
  const ChangeCompanyPage({Key? key}) : super(key: key);

  @override
  State<ChangeCompanyPage> createState() => _ChangeCompanyPageState();
}

class _ChangeCompanyPageState extends State<ChangeCompanyPage> {
  late bool _onPressButton;
  final emailController = TextEditingController();

  @override
  void initState() {
    _onPressButton = true;
    emailController.addListener(() {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text)) {
        setState(() {
          _onPressButton = false;
        });
      } else {
        setState(() {
          _onPressButton = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
          child: ListView(
            children: [
              _buildImageLogo('assets/images/logo.png'),
              CusTomTextFieldNoIcon(
                  text: 'Nhập vào địa chỉ email...',
                  controller: emailController,
                  isObsCurrentText: false),
              CustomButton(
                  text: 'Processs',
                  isActive: _onPressButton,
                  onPressed: onPressButton)
            ],
          ),
        ));
  }

  Padding _buildImageLogo(String s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(110, 50, 110, 50),
      child: Image.asset(s),
    );
  }

  onPressButton() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const LoginPage()), (route) => false);
  }
}
