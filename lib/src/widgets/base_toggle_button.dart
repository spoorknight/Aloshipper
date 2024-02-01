import 'dart:io';

import 'package:app_shipper/src/configs/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseToggleButton extends StatelessWidget {
  const BaseToggleButton({super.key, this.onChange, this.currentValue = false});

  final Function(bool value)? onChange;
  final bool currentValue;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Switch(
        // // thumb color (round icon)
        activeColor: Palette.blue,
        // activeTrackColor: Colors.cyan,
        // inactiveThumbColor: Colors.blueGrey.shade600,
        // inactiveTrackColor: Colors.grey.shade400,
        // splashRadius: 50.0,
        value: currentValue,
        // changes the state of the switch
        onChanged: (value) {
          if (onChange != null) {
            onChange!(value);
          }
        },
      );
    } else {
      return CupertinoSwitch(
        // // overrides the default green color of the track
        activeColor: Palette.blue,
        // // color of the round icon, which moves from right to left
        // thumbColor: color_blue,
        // // when the switch is off
        // trackColor: Colors.cyan,
        value: currentValue,
        // changes the state of the switch
        onChanged: (value) {
          if (onChange != null) {
            onChange!(value);
          }
        },
      );
    }
  }
}
