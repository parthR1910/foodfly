import 'package:flutter/services.dart';
import 'package:food_fly_delivery_partner/common/config/theme/theme_export.dart';
import 'package:food_fly_delivery_partner/common/utils/extentions/context_extention.dart';

class CommonFormField extends StatelessWidget {
  const CommonFormField(
      {super.key,
      required this.hintText,
       this.onSaved,
      this.obscureText =false,
      this.suffixIcon, this.prefixIcon,
      this.validator,
      this.initialValue, this.controller, this.textInputAction, this.autovalidateMode, this.keyboardType, this.inputFormatters, this.onChanged});

  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;



  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      initialValue: initialValue,
      controller: controller,
      textInputAction: textInputAction,
      autovalidateMode: autovalidateMode,
      obscuringCharacter: "*",
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      style: TextStyle(fontSize: 14.sp),
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:  BorderSide(color: context.primaryColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.grey))),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
