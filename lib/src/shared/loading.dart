import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../configs/palette.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, this.size = 32}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: Palette.green,
        size: size,
      ),
    );
  }
}
