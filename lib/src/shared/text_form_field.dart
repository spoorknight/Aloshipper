import 'package:app_shipper/src/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../configs/config.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
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
    this.decoration,
    this.border,
    this.textAlignVertical,
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
  final InputDecoration? decoration;
  final InputBorder? border;
  final TextAlignVertical? textAlignVertical;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool showPass;

  @override
  void initState() {
    showPass = false;
    super.initState();
  }

  void togglePass() {
    setState(() {
      showPass = !showPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: widget.width ?? double.infinity,
          height: widget.height,
          child: TextFormField(
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
            onChanged: widget.onChanged,
            onTap: widget.onTap,
            textAlignVertical: widget.textAlignVertical,
            decoration: widget.decoration ??
                const InputDecoration()
                    .applyDefaults(widget.border != null
                        ? AppTheme.textFormFieldNonBorder(widget.border)
                        : AppTheme.textFormField(widget.radius))
                    .copyWith(
                      counterText: "",
                      floatingLabelAlignment: widget.centerTitle == true
                          ? FloatingLabelAlignment.center
                          : null,
                      labelText: widget.title,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.hintText,
                      prefixIcon: widget.prefixIcon,
                      contentPadding: widget.contentPadding,
                      suffixIcon: widget.suffixIcon,
                    ),
            onSaved: (_) => widget.onSaved,
            controller: widget.controller,
            autovalidateMode: widget.autovalidateMode,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            focusNode: widget.focusNode,
          ),
        ),
        if (widget.isPassword)
          Positioned(
            right: 0,
            child: IconButton(
              icon: showPass
                  ? const Icon(Icons.visibility_off, color: Palette.grey)
                  : const Icon(Icons.visibility, color: Palette.grey),
              onPressed: togglePass,
            ),
          )
      ],
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


class CustomTextFormFieldVerify extends StatefulWidget {
  const CustomTextFormFieldVerify({
    Key? key,
    this.title,
    this.hintText,
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
    this.isRequired = true,
    this.focusNode,
    this.decoration,
    this.border,
    this.textAlignVertical,
  }) : super(key: key);

  final String? title;
  final String? hintText;
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
  final bool isRequired;
  final VoidCallback? onTap;
  final int maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final InputBorder? border;
  final TextAlignVertical? textAlignVertical;

  @override
  State<CustomTextFormFieldVerify> createState() => _CustomTextFormFieldVerifyState();
}

class _CustomTextFormFieldVerifyState extends State<CustomTextFormFieldVerify> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: widget.width ?? double.infinity,
          height: 69,
          child: Column(
            children: [
              Row(
                children: [
                  Text(widget.title ?? "",style: AppFont.t,),
                  Text(" *",style: AppFont.t.red,)
                ],
              ),
              TextFormField(
                textAlign: widget.textAlign,
                maxLines: widget.maxLines,
                style: AppFont.t.black.w500,
                initialValue: widget.initialValue,
                key: widget.key,
                keyboardType: widget.inputType,
                obscuringCharacter: '*',
                autocorrect: false,
                readOnly: widget.readOnly,
                maxLength: widget.maxLength,
                onChanged: widget.onChanged,
                onTap: widget.onTap,
                textAlignVertical: widget.textAlignVertical,
                decoration: widget.decoration ??
                    const InputDecoration()
                        .applyDefaults( AppTheme.textFormFieldNonBorder(widget.border)
                      )
                        .copyWith(
                      counterText: "",
                      floatingLabelAlignment: widget.centerTitle == true
                          ? FloatingLabelAlignment.center
                          : null,
                      // labelText: widget.title,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: widget.hintText,
                      prefixIcon: widget.prefixIcon,
                      contentPadding: widget.contentPadding,
                      suffixIcon: widget.suffixIcon,
                    ),
                onSaved: (_) => widget.onSaved,
                controller: widget.controller,
                autovalidateMode: widget.autovalidateMode,
                inputFormatters: widget.inputFormatters,
                validator: widget.validator,
                focusNode: widget.focusNode,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

