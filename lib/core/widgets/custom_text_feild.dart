import 'package:flutter/material.dart';
import 'package:hack_talk/core/theming/app_colors.dart';

class CustomTextFormFeild extends StatefulWidget {
  final String hintText;
  final TextInputType kbType;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Function? onSubmit;
  final Function? onTap;
  final String? lableText;
  final bool? isObscureText;
  final String? Function(String?)? validator;
  final String? value;

  const CustomTextFormFeild({
    super.key,
    this.suffixIcon,
    required this.hintText,
    required this.kbType,
    required this.controller,
    this.onSubmit,
    this.onTap,
    this.lableText,
    this.isObscureText,
    this.validator,
    this.value,
  });

  @override
  State<CustomTextFormFeild> createState() => _CustomTextFormFeildState();
}

class _CustomTextFormFeildState extends State<CustomTextFormFeild> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          label: Container(
            margin: const EdgeInsets.symmetric(horizontal: 9),
            child: Text(
              widget.lableText ?? '',
              style: const TextStyle(color: AppColors.mainColor, fontSize: 16),
            ),
          ),
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 16),
          suffixIcon: widget.suffixIcon,
          isDense: false,
          fillColor: AppColors.textFormFeild,
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                const BorderSide(color: AppColors.mainColor, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                const BorderSide(color: AppColors.textFormFeild, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide:
                const BorderSide(color: AppColors.textFormFeild, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: AppColors.textFormFeild),
          ),
          focusColor: AppColors.black,
          hintText: widget.hintText,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintStyle: const TextStyle(color: Colors.grey, fontFamily: "Roboto"),
        ),
        obscureText: widget.isObscureText ?? false,
        validator: widget.validator,
      ),
    );
  }
}
