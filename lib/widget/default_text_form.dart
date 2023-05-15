import 'package:flutter/material.dart';

class DefaultTextForm extends StatelessWidget {
  final TextEditingController controller;
  final Function? onsubmit;
  final String lable;
  final IconData prefix;
  final Function()? onTap;
  final TextInputType? type;
  final Function validator;
  final IconData? suffix;
  final bool enable = true;
  final bool? isPassword ;
  const DefaultTextForm(
      {super.key,
      required this.controller,
      required this.validator,
      required this.lable,
      required this.prefix,
      this.onsubmit,
      this.onTap,
      this.type,
      this.suffix,
         this.isPassword = false,
        });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword!,
      keyboardType: type,
      onFieldSubmitted: (d) {
        onsubmit!(d);
      },
      validator: (value) => validator(value),
      onTap: () {
        onTap!();
      },
      enabled: enable,
      decoration: InputDecoration(
        labelText: lable,
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null ? Icon(suffix) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
    ;
  }
}
