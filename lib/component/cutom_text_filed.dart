import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshed/constant/text_theme.dart';

import '../constant/const_color.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function? onTap;
  final int? length;
  final int? lines;
  final double? padding;
  final double? maxHeight;
  final double? minHeight;
  final double? maxWidth;
  final double? minWidth;
  final Function? validator;
  final bool? secure;
  bool isTabbed=false;
  bool isBig = false;
  bool isEnabled = true;

  CustomTextField({
    super.key,
    required this.labelText,
    this.hintText,
    this.controller,
    this.secure,
    this.prefixIcon,
    this.padding,
    this.isBig = false,
    this.isTabbed=false,
    this.isEnabled = true,
    this.keyboardType,
    this.suffixIcon,
    this.onTap,
    this.length,
    this.lines,
    this.validator,
    this.maxHeight,
    this.minHeight,
    this.maxWidth,
    this.minWidth,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:widget.padding??0.h),
      child: TextFormField(

        controller: widget.controller,
        style: cairoSemiBold.copyWith(fontSize: 14),
        onTap: () {
          widget.onTap==null?setState((){
            widget.controller?.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller!.text.length));
          }): print('');
        },
        maxLines: widget.lines ?? 1,
        maxLength: widget.length,
        decoration: InputDecoration(
            contentPadding: EdgeInsetsDirectional.only(
                start: 10.w, top: widget.isBig ? 20.h : 0.0),
            constraints: BoxConstraints(
                minHeight: widget.minHeight ?? 54.h,
                minWidth: widget.minWidth ?? 330.w,
                maxHeight: widget.maxHeight ?? 54.h,
                maxWidth: widget.maxWidth ?? 360.w),
            suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
            labelText: widget.labelText,
            labelStyle:cairoSemiBold.copyWith(fontSize: 14,color: greyColor) ,
            hintText: widget.hintText,
            errorStyle:cairoSemiBold.copyWith(fontSize: 14,color: Colors.red),
            hintStyle: cairoMedium.copyWith(fontSize: 10,color: greyColor),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.sp))),
        validator: (val) {
          return widget.validator!(val);
        },
        keyboardType: widget.keyboardType,
        obscureText: widget.secure ?? false,
        enabled: widget.isEnabled,
      ),
    );
  }
}
