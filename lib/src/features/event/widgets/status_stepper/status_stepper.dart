import 'package:flutter/material.dart';

import 'stepper_connector.dart';
import 'stepper_item.dart';

class StatusStepper extends StatelessWidget {
  ///Duration multiplyes by 2(for animating connector and item) * n(n - count of children to animate)
  final Duration animationDuration;

  ///Duration before starting animation
  final Duration animationDelayDuration;

  ///Current status index, -1 if there are no  active items
  final int currentIndex;

  ///Animation starts after widget at this position
  final int lastActiveIndex;

  final List<Widget> children;

  ///Color of next statuses, by default is Theme.of(context).colorScheme.secondaryVariant
  final Color? disabledColor;

  ///Curve for the connectors
  final Curve connectorCurve;

  ///Curve for the status widgets
  final Curve itemCurve;

  final double connectorThickness;

  const StatusStepper({
    required this.children,
    this.animationDuration = const Duration(milliseconds: 200),
    this.lastActiveIndex = -1,
    this.currentIndex = -1,
    this.animationDelayDuration = Duration.zero,
    this.connectorCurve = Curves.linear,
    this.itemCurve = Curves.linear,
    this.connectorThickness = 2,
    this.disabledColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _children = <Widget>[];
    for (var index = 0; index < children.length; index++) {
      final delayFactor =
          index - lastActiveIndex > 1 ? index - lastActiveIndex - 1 : 0;
      final isNotCurrentIndex = currentIndex != lastActiveIndex;
      if (index != children.length - 1) {
        _children.addAll(
          [
            StepperConnector(
              isFirst: index == 0,
              isLast: index == children.length - 1,
              animationDuration: animationDuration,
              isPassed: index <= currentIndex,
              shouldRedraw: index > lastActiveIndex,
              delayFactor: delayFactor * 2 -
                  (!isNotCurrentIndex && delayFactor > 0 ? 1 : 0),
              animationAwaitDuration: animationDelayDuration,
              disabledColor: disabledColor,
              curve: connectorCurve,
              connectorThickness: connectorThickness,
            ),
            children[index]
          ],
        );
      } else {
        _children.addAll(
          [
            StepperConnector(
              isFirst: index == 0,
              isLast: index == children.length - 1,
              animationDuration: animationDuration,
              isPassed: index <= currentIndex,
              shouldRedraw: index > lastActiveIndex,
              delayFactor: delayFactor * 2 -
                  (!isNotCurrentIndex && delayFactor > 0 ? 1 : 0),
              animationAwaitDuration: animationDelayDuration,
              disabledColor: disabledColor,
              curve: connectorCurve,
              connectorThickness: connectorThickness,
            ),
          ],
        );
      }
    }

    return Row(
      children: _children,
    );
  }
}
