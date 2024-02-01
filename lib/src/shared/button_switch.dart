import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class ButtonSwitch extends StatefulWidget {
  const ButtonSwitch({super.key, this.onTap, this.initState = false});

  final Function(bool value)? onTap;
  final bool initState;

  @override
  State<ButtonSwitch> createState() => _ButtonSwitchState();
}

class _ButtonSwitchState extends State<ButtonSwitch> {
  // 1. Create a controller in the state of the StatefulWidget
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (widget.onTap != null) {
        widget.onTap!(_controller.value);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant ButtonSwitch oldWidget) {
    _controller.value = widget.initState;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedSwitch(
      controller: _controller,
    );
  }
}
