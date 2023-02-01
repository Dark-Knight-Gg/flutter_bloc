import 'package:flutter/material.dart';
import 'package:vti_express/ui/forgot_password/pincode_bottom_sheet.dart';

import '../../common/build_widget.dart';


class ForgotPasswordBottomSheet extends StatefulWidget {
  const ForgotPasswordBottomSheet({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordBottomSheet> createState() =>
      _ForgotPasswordBottomSheetState();
}

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          15, 30, 15, MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
                text: 'Quên mật khẩu',
                size: 20,
                color: Colors.black,
                paddingBottom: 30),
            CustomText(
                text:
                    'Hãy nhập email của bạn để tiến hành quá trình xác nhận, chúng tôi sẽ gửi đến email của bạn một mã gồm 6 số',
                size: 15,
                color: Colors.grey,
                paddingBottom: 40),
            CustomText(
                text: 'Email',
                size: 17,
                color: Colors.black,
                paddingBottom: 20),
            CusTomTextFieldNoIcon(
                text: 'Nhập vào địa chỉ email...',
                controller: emailController,
                isObsCurrentText: false),
            CustomButton(
              text: 'Tiếp tục',
              isActive: _onPressButton,
              onPressed: onPressButton,
            ),
          ],
        ),
      ),
    );
  }

  onPressButton() {
    Navigator.of(context).pop();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        // return Padding(
        //   padding: EdgeInsets.only(
        //     bottom: MediaQuery.of(context).viewInsets.bottom,
        //   ),
        //   child: const PinCode(),
        // );
        return const PinCode();
      },
    );
  }
}
