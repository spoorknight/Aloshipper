import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../configs/config.dart';

class BaseTextFormField extends StatefulWidget {
  const BaseTextFormField({
    Key? key,
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
    this.border,
    this.textAlignVertical,
    this.decoration,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.decorationContainer,
  }) : super(key: key);

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
  final double? border;
  final TextAlignVertical? textAlignVertical;
  final InputDecoration? decoration;
  final TextCapitalization textCapitalization;
  final bool? enabled;
  final Decoration? decorationContainer;

  @override
  State<BaseTextFormField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseTextFormField> {
  late bool showPass;
  late bool showClear;

  @override
  void initState() {
    showPass = false;
    showClear = false;
    super.initState();
  }

  void togglePass() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: AppFont.t.s(16).w700.nuatral90,
          ),
          BoxConst.s4,
        ],
        Container(
          decoration: AppTheme.boxDecoration.copyWith(
              borderRadius: BorderRadius.circular(widget.border ?? 8.r),
              color: Palette.white),
          width: widget.width ?? double.infinity,
          height: widget.height,
          child: TextFormField(
            textCapitalization: widget.textCapitalization,
            textAlign: widget.textAlign,
            maxLines: widget.maxLines,
            initialValue: widget.initialValue,
            key: widget.key,
            keyboardType: widget.inputType,
            obscureText: widget.isPassword && !showPass,
            obscuringCharacter: '*',
            autocorrect: false,
            readOnly: widget.readOnly,
            maxLength: widget.maxLength,
            onChanged: (value) {
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
              if (showClear && value.isEmpty) {
                setState(() {
                  showClear = false;
                });
              }
              if (!showClear && value.isNotEmpty) {
                setState(() {
                  showClear = true;
                });
              }
            },
            onTap: widget.onTap,
            textAlignVertical:
                widget.textAlignVertical ?? TextAlignVertical.center,
            enabled: widget.enabled,
            decoration: widget.decoration ??
                const InputDecoration()
                    .applyDefaults(AppTheme.baseTextFormField())
                    .copyWith(
                      counterText: "",
                      floatingLabelAlignment: widget.centerTitle == true
                          ? FloatingLabelAlignment.center
                          : null,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.hintText,
                      prefixIcon: widget.prefixIcon,
                      contentPadding: widget.contentPadding,
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (showClear && (widget.enabled == true))
                            InkWell(
                              onTap: () {
                                if (widget.onChanged != null) {
                                  widget.onChanged!('');
                                }
                                widget.controller?.clear();
                                setState(() {
                                  showClear = false;
                                });
                              },
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Palette.buttonGrey,
                              ),
                            ),
                          if (widget.suffixIcon != null) ...[
                            BoxConst.s8,
                            widget.suffixIcon!
                          ],
                          if (widget.isPassword)
                            IconButton(
                              icon: showPass
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Palette.grey,
                                      size: 18.sp,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: Palette.grey,
                                      size: 18.sp,
                                    ),
                              onPressed: togglePass,
                            )
                        ],
                      ),
                    ),
            onSaved: (_) => widget.onSaved,
            controller: widget.controller,
            autovalidateMode: widget.autovalidateMode,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            focusNode: widget.focusNode,
          ),
        ),
      ],
    );
  }
}

class UppercaseTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class UnSignTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.unSign(),
      selection: newValue.selection,
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final int value = int.tryParse(newValue.text.replaceAll(',', '')) ?? 0;
    final String formattedValue = value.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
