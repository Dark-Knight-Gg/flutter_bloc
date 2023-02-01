import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../common/build_widget.dart';
import '../login_page/login_page.dart';



class PinCode extends StatefulWidget {
  const PinCode({Key? key}) : super(key: key);

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  late bool _onPressButton;
  late String pinCode;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    _onPressButton = true;
    controller.addListener(() {
      if (controller.text.length == 6) {
        _onPressButton = false;
      }
    });

    super.initState();
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: 'Nhập mã 6 ký tự số',
                size: 20,
                color: Colors.black,
                paddingBottom: 20),
            CustomText(
                text: 'Nhập mã 6 ký tự số bạn nhận được từ email.',
                size: 15,
                color: Colors.grey,
                paddingBottom: 30),
            CustomText(
                text: 'Nhập mã',
                size: 17,
                color: Colors.black87,
                paddingBottom: 20),
            _buildPinCode(),
            CustomButton(
                text: 'Tiếp tục',
                isActive: _onPressButton,
                onPressed: onPressButton)
          ],
        ),
      ),
    );
  }

  Padding _buildPinCode() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: PinCodeTextField(
        appContext: context,
        controller: controller,
        length: 6,
        enableActiveFill: true,
        textStyle: GoogleFonts.inter(
            textStyle: const TextStyle(fontSize: 19, color: Colors.black87)),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          fieldWidth: 50,
          activeColor: Colors.grey,
          inactiveColor: Colors.grey,
          selectedColor: Colors.blueAccent,
          activeFillColor: Colors.white,
          selectedFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          disabledColor: Colors.white,
          borderWidth: 1,
          borderRadius: BorderRadius.circular(12),
        ),
        onChanged: ((value) {
          if (value.length == 6) {
            pinCode = value;
          }
        }),
      ),
    );
  }

  onPressButton() {
    if (pinCode.compareTo('260401') == 0) {
      Fluttertoast.showToast(
          msg: "Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: "Erorr",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false);
    }
  }
}
