import 'package:flutter/material.dart';

import '../../../../configs/config.dart';

class StepperConnector extends StatelessWidget {
  final bool isPassed;
  final bool shouldRedraw;
  final int delayFactor;
  final Duration animationDuration;
  final Duration animationAwaitDuration;
  final Color? disabledColor;
  final Curve curve;
  final double connectorThickness;
  final bool isLast;
  final bool isFirst;

  const StepperConnector({
    Key? key,
    required this.isPassed,
    required this.delayFactor,
    required this.shouldRedraw,
    required this.animationDuration,
    required this.curve,
    required this.connectorThickness,
    this.animationAwaitDuration = Duration.zero,
    this.disabledColor,
    this.isLast = false,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          renderLine(
            color:
                disabledColor ?? Theme.of(context).colorScheme.secondaryVariant,
          ),
          FutureBuilder(
            future: Future.delayed(
              animationDuration * delayFactor + animationAwaitDuration,
            ),
            builder: (context, snapshot) => AnimatedSwitcher(
              switchInCurve: curve,
              transitionBuilder: (child, animation) => SizeTransition(
                sizeFactor: animation,
                child: child,
                axis: Axis.horizontal,
              ),
              duration: animationDuration,
              child: isPassed &&
                          snapshot.connectionState == ConnectionState.done ||
                      !shouldRedraw
                  ? renderLine(
                      // activeColor ?? Theme.of(context).primaryColor,
                      colors: Palette.btnHarvest,
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderLine({Color? color, List<Color>? colors}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        gradient: colors != null
            ? LinearGradient(
                colors: colors,
              )
            : null,
        borderRadius: BorderRadius.only(
            topLeft: isFirst ? Radius.circular(16.r) : const Radius.circular(0),
            bottomLeft:
                isFirst ? Radius.circular(16.r) : const Radius.circular(0),
            topRight: isLast ? Radius.circular(16.r) : const Radius.circular(0),
            bottomRight:
                isLast ? Radius.circular(16.r) : const Radius.circular(0)),
      ),
      height: connectorThickness,
    );
  }
}
