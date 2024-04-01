import 'package:flutter/material.dart';

import '../styles/colors.dart';

class TextFormFieldCustom extends StatelessWidget {
  const TextFormFieldCustom({
    super.key,
    this.labelText,
    this.controller,
    this.prefixIcon,
    this.hintText,
    this.onSubmitted,
    this.onChanged,
    this.flex = 1,
     this.enabled,
  });

  final int flex;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final bool? enabled ;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          enabled: enabled!,
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsAsset.mainColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsAsset.mainColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorsAsset.mainColor),
          ),
        ),
      ),
    );
  }
}
