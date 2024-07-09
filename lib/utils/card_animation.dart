import 'package:flutter/material.dart';
import 'package:my_wordbook/theme/deco_const.dart';

class WordCardAnimations {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> rotationAnimation;
  late Animation<Color?> colorAnimation;

  WordCardAnimations(TickerProvider vsync) {
    controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 250),
    );

    scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    rotationAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.3)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.15, end: -0.3)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.3, end: 0.0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 50,
      ),
    ]).animate(controller);

    colorAnimation = ColorTween(
      begin: DecoConst.cardColor,
      end: DecoConst.mainColor,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void dispose() {
    controller.dispose();
  }
}
