import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../configs/config.dart';

class DropDownTuple2<T> extends StatelessWidget {
  const DropDownTuple2({
    Key? key,
    required this.listItem,
    required this.value,
    this.required = true,
    this.onChange,
    this.style,
    this.title,
    this.hintText,
    this.height,
    this.isBorder = false,
    this.isExpanded = false,
    this.textStyle,
  }) : super(key: key);
  final List<Tuple2<String?, T>> listItem;
  final Function? onChange;
  final T value;
  final String? title;
  final bool? required;
  final TextStyle? style;
  final String? hintText;
  final double? height;
  final bool isBorder;
  final bool isExpanded;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
      isExpanded: isExpanded,
      hint: Text(hintText ?? '', style: AppFont.t.hint),
      icon: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Icon(
          Icons.arrow_drop_down,
          color: Palette.grey,
        ),
      ),
      buttonHeight: height ?? 48,
      buttonDecoration: isBorder == true
          ? BoxDecoration(
              border: Border.all(color: Palette.grey),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      underline: const SizedBox(),
      dropdownDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      itemPadding: const EdgeInsets.symmetric(horizontal: 8),
      items: [
        ...listItem.map((e) => DropdownMenuItem<T>(
              value: e.item2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(e.item1 ?? "", style: textStyle ?? AppFont.t),
              ),
            ))
      ],
      value: value,
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value);
        }
      },
    );
  }
}

class DropDownCustom<T> extends StatelessWidget {
  const DropDownCustom({
    Key? key,
    this.listTuple,
    this.listDynamic,
    required this.value,
    this.required = true,
    this.onChange,
    this.style,
    this.title,
    this.hintText,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.searchMatchFn,
    this.searchController,
    this.canSearch = false,
    this.selectedItemBuilder,
  }) : super(key: key);
  final List<DropdownMenuItem<T>>? listDynamic;
  final List<Tuple2<String?, T>>? listTuple;
  final ValueChanged? onChange;
  final T? value;
  final String? title;
  final bool? required;
  final TextStyle? style;
  final String? hintText;
  final FormFieldValidator? validator;
  final AutovalidateMode autovalidateMode;
  final bool Function(DropdownMenuItem<dynamic>, String)? searchMatchFn;
  final TextEditingController? searchController;
  final bool canSearch;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField2<T>(
          dropdownMaxHeight: 0.5.sh,
          autovalidateMode: autovalidateMode,
          isExpanded: true,
          hint: hintText != null
              ? Text(hintText ?? '', style: AppFont.t.hint)
              : null,
          icon: const Icon(Icons.arrow_drop_down),
          buttonHeight: 48,
          decoration: const InputDecoration()
              .applyDefaults(AppTheme.textFormField())
              .copyWith(
                labelText: title,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
          searchMatchFn: searchMatchFn,
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              searchController?.clear();
            }
          },
          itemPadding: EdgeInsets.zero,
          searchController: searchController,
          searchInnerWidgetHeight: canSearch ? 56 : null,
          searchInnerWidget: canSearch
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: TextFormField(
                    controller: searchController,
                    decoration: const InputDecoration()
                        .applyDefaults(AppTheme.textFormField())
                        .copyWith(
                          hintText: 'Tìm kiếm',
                        ),
                  ),
                )
              : null,
          dropdownDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          items: listTuple != null
              ? listTuple!
                  .map(
                    (e) => DropdownMenuItem<T>(
                      value: e.item2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(e.item1 ?? ""),
                      ),
                    ),
                  )
                  .toList()
              : listDynamic,
          selectedItemBuilder: selectedItemBuilder ??
              (context) => listTuple != null
                  ? listTuple!.map((e) => Text(e.item1 ?? "")).toList()
                  : listDynamic ?? [],
          value: value,
          validator: validator,
          onChanged: (value) {
            if (onChange != null) {
              onChange!(value);
            }
          },
        ),
      ],
    );
  }
}



class DropDownCustomVerify<T> extends StatelessWidget {
  const DropDownCustomVerify({
    Key? key,
    this.listTuple,
    this.listDynamic,
    required this.value,
    this.required = true,
    this.onChange,
    this.style,
    this.title,
    this.hintText,
    this.validator,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.searchMatchFn,
    this.searchController,
    this.canSearch = false,
    this.selectedItemBuilder,
  }) : super(key: key);
  final List<DropdownMenuItem<T>>? listDynamic;
  final List<Tuple2<String?, T>>? listTuple;
  final ValueChanged? onChange;
  final T? value;
  final String? title;
  final bool? required;
  final TextStyle? style;
  final String? hintText;
  final FormFieldValidator? validator;
  final AutovalidateMode autovalidateMode;
  final bool Function(DropdownMenuItem<dynamic>, String)? searchMatchFn;
  final TextEditingController? searchController;
  final bool canSearch;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(title ?? "",style: AppFont.t,),
            Text(" *",style: AppFont.t.red,)
          ],
        ),
        DropdownButtonFormField2<T>(
          dropdownMaxHeight: 0.5.sh,
          autovalidateMode: autovalidateMode,
          isExpanded: true,
          hint: hintText != null
              ? Text(hintText ?? '', style: AppFont.t.hint)
              : null,
          icon: const RotatedBox(
              quarterTurns:1 ,
              child: Icon(Icons.navigate_next)),
          decoration: const InputDecoration()
              .applyDefaults(AppTheme.textFormFieldNonBorder())
              .copyWith(
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          searchMatchFn: searchMatchFn,
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              searchController?.clear();
            }
          },
          itemPadding: EdgeInsets.zero,
          searchController: searchController,
          searchInnerWidgetHeight: canSearch ? 56 : null,
          searchInnerWidget: canSearch
              ? Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration()
                  .applyDefaults(AppTheme.textFormField())
                  .copyWith(
                hintText: 'Tìm kiếm',
              ),
            ),
          )
              : null,
          items: listTuple != null
              ? listTuple!
              .map(
                (e) => DropdownMenuItem<T>(
              value: e.item2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(e.item1 ?? ""),
              ),
            ),
          )
              .toList()
              : listDynamic,
          selectedItemBuilder: selectedItemBuilder ??
                  (context) => listTuple != null
                  ? listTuple!.map((e) => Text(e.item1 ?? "")).toList()
                  : listDynamic ?? [],
          value: value,
          validator: validator,
          onChanged: (value) {
            if (onChange != null) {
              onChange!(value);
            }
          },
        ),
      ],
    );
  }
}

