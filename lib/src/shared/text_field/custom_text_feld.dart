import 'package:app_shipper/src/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configs/config.dart';
import '../../utils/app_enum.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.title,
    this.hintText,
    this.isPassword = false,
    this.inputType,
    this.controller,
    this.maxLength,
    this.onSubmitted,
    this.initialValue,
    this.onSaved,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.errorText,
    this.radius = 8,
    this.centerTitle = false,
    this.prefixIcon,
    this.width,
    this.height,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.contentPadding,
    this.suffixIcon,
    this.textAlign = TextAlign.start,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.isRequire = false,
    this.inputTextType = InputTextType.input,
    this.enabled = true,
    this.decoration,
    this.paddingContainer,
    this.marginContainer,
  });

  final String? title;
  final String? hintText;
  final bool isPassword;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final int? maxLength;
  final Function? onSubmitted;
  final String? initialValue;
  final FormFieldSetter<String>? onSaved;
  final AutovalidateMode? autovalidateMode;
  final Function(String)? onChanged;
  final String? errorText;
  final double radius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? centerTitle;
  final double? width;
  final double? height;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool? isRequire;
  final InputTextType? inputTextType;
  final bool? enabled;
  final Decoration? decoration;
  final EdgeInsetsGeometry? paddingContainer;
  final EdgeInsetsGeometry? marginContainer;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.device.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
              text: widget.title,
              style: AppFont.t.s(13).w700.nuatral90,
              children: [
                if (widget.isRequire == true)
                  TextSpan(
                    text: ' *',
                    style: AppFont.t.s(13).w700.red,
                  )
              ])),
          Container(
            decoration: widget.decoration,
            margin: widget.marginContainer,
            padding: widget.paddingContainer,
            child: TextFormField(
              enabled: widget.enabled,
              textAlign: widget.textAlign,
              maxLines: widget.maxLines,
              initialValue: widget.initialValue,
              key: widget.key,
              keyboardType: widget.inputType,
              autocorrect: false,
              readOnly: widget.readOnly,
              maxLength: widget.maxLength,
              onChanged: widget.onChanged,
              onTap: widget.onTap,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                contentPadding: widget.contentPadding ?? EdgeInsets.zero,
              ),
              onSaved: (_) => widget.onSaved,
              controller: widget.controller,
              autovalidateMode: widget.autovalidateMode,
              inputFormatters: widget.inputFormatters,
              validator: widget.validator,
              focusNode: widget.focusNode,
            ),
          ),
          const Divider(
            color: Palette.nuatral20,
            height: 1,
          ),
        ],
      ),
    );
  }
}
