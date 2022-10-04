import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredArea extends StatelessWidget {
  final Widget child;

  const BlurredArea({Key? key,required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: child,
        ),
      ),
    );
  }
}
