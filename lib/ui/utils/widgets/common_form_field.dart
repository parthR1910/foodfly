import 'package:flutter/services.dart';
import 'package:food_fly/ui/utils/theme/app_colors.dart';
import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:food_fly/ui/utils/theme/theme.dart';

class CommonFormField extends StatelessWidget {
  const CommonFormField(
      {super.key,
      required this.hintText,
       this.onSaved,
      this.obscureText =false,
      this.suffixIcon,
      this.validator,
      this.initialValue, this.controller, this.textInputAction, this.autovalidateMode, this.keyboardType, this.inputFormatters});

  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Widget? suffixIcon;
  final String? initialValue;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;



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
      style: AppTextStyle.w4.copyWith(fontSize: 14.sp),
      decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: suffixIcon,
          hintStyle: AppTextStyle.w4.copyWith(color: AppColors.kGrey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.kPrimary)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.kGrey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: AppColors.kGrey))),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
