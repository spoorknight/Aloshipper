import 'package:flutter/material.dart';

class SafeButton extends StatelessWidget {
  const SafeButton({
    Key? key,
    required this.child,
    required this.onSafeTap,
    this.intervalMs = 500,
  }) : super(key: key);
  final Widget child;
  final VoidCallback? onSafeTap;
  final int intervalMs;

  @override
  Widget build(BuildContext context) {
    int lastTimeClicked = 0;
    return GestureDetector(
      onTap: () {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (now - lastTimeClicked > intervalMs) {
          lastTimeClicked = now;
          onSafeTap!();
        }
      },
      child: child,
    );
  }
}
