import 'package:flutter/material.dart';

import '../configs/config.dart';

class CheckBoxCustom extends StatefulWidget {
  final String? title;
  final bool isChecked;
  final Function(bool value) onPress;

  const CheckBoxCustom(
      {Key? key, this.title, required this.onPress, required this.isChecked})
      : super(key: key);

  @override
  CheckBoxCustomState createState() => CheckBoxCustomState();
}

class CheckBoxCustomState extends State<CheckBoxCustom> {
  bool _isCheck = false;
  @override
  void initState() {
    super.initState();
    _isCheck = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              setState(() {
                _isCheck = !_isCheck;
                widget.onPress(widget.isChecked);
              });
            },
            icon: Container(
                decoration: BoxDecoration(
                  color: _isCheck ? Palette.green : Colors.white,
                  border: Border.all(color: Palette.grey),
                ),
                child: const Icon(Icons.check, size: 18, color: Colors.white))),
        BoxConst.s8,
        Text(widget.title ?? '', style: AppFont.t)
      ],
    );
  }
}
