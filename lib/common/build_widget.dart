import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui/login_page/bloc/password_visible_cubit.dart';

///Custom text
class CustomText extends StatelessWidget {
  String text = "";
  double size = 15;
  Color color = Colors.black;
  double paddingBottom = 0;

  CustomText(
      {required this.text,
      required this.size,
      required this.color,
      required this.paddingBottom,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Text(
        text,
        style: GoogleFonts.inter(
            textStyle: TextStyle(fontSize: size, color: color)),
      ),
    );
  }
}

/// Custom TextField No Icon

class CusTomTextFieldNoIcon extends StatelessWidget {
  String text = "";
  bool isObsCurrentText = false;
  TextEditingController controller = TextEditingController();

  CusTomTextFieldNoIcon(
      {required this.text,
      required this.controller,
      required this.isObsCurrentText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 20),
      child: SizedBox(
        height: 45,
        child: TextField(
          controller: controller,
          style: GoogleFonts.inter(
              textStyle: const TextStyle(fontSize: 17), color: Colors.black),
          obscureText: isObsCurrentText,
          obscuringCharacter: "*",
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
            isDense: true,
            filled: true,
            fillColor: const Color(0xFFECF4FD),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(width: 0.7, color: Colors.lightBlue),
            ),
            hintText: '$text',
            hintStyle: const TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }
}

/// Custom TextField Have Icon
class CustomTextFieldHaveIcon extends StatefulWidget {
  String text = "";
  TextEditingController controller = TextEditingController();
  bool suffixIcon = true;
  bool visible = true;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  CustomTextFieldHaveIcon(
      {required this.text,
      required this.visible,
      required this.controller,
      required this.suffixIcon,
      required this.onChanged,
      required this.errorText,
      Key? key})
      : super(key: key);

  @override
  State<CustomTextFieldHaveIcon> createState() =>
      _CustomTextFieldHaveIconState();
}

class _CustomTextFieldHaveIconState extends State<CustomTextFieldHaveIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child:SizedBox(
              height: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: widget.controller,
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(fontSize: 17),
                      color: Colors.black),
                  obscureText: widget.visible,
                  obscuringCharacter: "*",
                  textAlignVertical: TextAlignVertical.bottom,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    errorText: widget.errorText,
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
                    isDense: true,
                    suffixIcon: widget.suffixIcon
                        ? null
                        : IconButton(
                            onPressed: () {
                              setState(() {
                                widget.visible = !widget.visible;
                              });
                            },
                            icon: Icon(widget.visible
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                    filled: true,
                    fillColor: const Color(0xFFECF4FD),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide:
                          BorderSide(width: 0.7, color: Colors.lightBlue),
                    ),
                    hintText: '${widget.text}',
                    hintStyle: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
        );
  }
}

///Custom Button

class CustomButton extends StatefulWidget {
  String text = "";
  bool isActive = true;
  final VoidCallback? onPressed;

  CustomButton(
      {required this.text,
      required this.isActive,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 40),
      child: SizedBox(
        height: 45,
        width: 347,
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: widget.isActive
                    ? MaterialStateProperty.all<Color>(const Color(0xffafaeae))
                    : MaterialStateProperty.all<Color>(const Color(0xff1d52f3)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        side: BorderSide.none))),
            onPressed: widget.isActive ? null : widget.onPressed,
            child: Text(
              '${widget.text}',
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            )),
      ),
    );
  }
}

///Custom Button
class CustomTextButton extends StatefulWidget {
  String text = "";
  final Widget builder;

  CustomTextButton({required this.text, required this.builder, Key? key})
      : super(key: key);

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return widget.builder;
                  },
                );
              },
              child: Text(
                widget.text,
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 14, color: Colors.blueAccent)),
              )),
        ],
      ),
    );
  }
}
