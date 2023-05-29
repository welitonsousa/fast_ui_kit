import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

enum FastAnimateType {
  none,
  fadeIn,
  fadeInDown,
  fadeInDownBig,
  fadeInUp,
  fadeInUpBig,
  fadeInLeft,
  fadeInLeftBig,
  fadeInRight,
  fadeInRightBig,

  fadeOut,
  fadeOutDown,
  fadeOutDownBig,
  fadeOutUp,
  fadeOutUpBig,
  fadeOutLeft,
  fadeOutLeftBig,
  fadeOutRight,
  fadeOutRightBig,

  bounceInDown,
  bounceInUp,
  bounceInLeft,
  bounceInRight,

  elasticIn,
  elasticInDown,
  elasticInUp,
  elasticInLeft,
  elasticInRight,

  slideInDown,
  slideInUp,
  slideInLeft,
  slideInRight,

  flipInX,
  flipInY,

  zoomIn,
  zoomOut,

  jelloIn,
  bounce,
  flash,
  pulse,
  swing,
  spin,
  spinPerfect,
  dance,
  roulette,
}

class FastAnimate extends StatelessWidget {
  final FastAnimateType type;
  final Duration delay;
  final Duration duration;
  final Widget child;

  const FastAnimate({
    super.key,
    required this.type,
    required this.child,
    this.delay = const Duration(milliseconds: 0),
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    if (type == FastAnimateType.fadeIn) {
      return FadeIn(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeInDown) {
      return FadeInDown(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeInDownBig) {
      return FadeInDownBig(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeInUp) {
      return FadeInUp(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeInUpBig) {
      return FadeInUpBig(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeInLeft) {
      return FadeInLeft(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeInLeftBig) {
      return FadeInLeftBig(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeInRight) {
      return FadeInRight(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeInRightBig) {
      return FadeInRightBig(
        delay: delay,
        duration: duration,
        child: child,
      );
    }

    if (type == FastAnimateType.fadeOut) {
      return FadeOut(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeOutDown) {
      return FadeOutDown(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeOutDownBig) {
      return FadeOutDownBig(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeOutUp) {
      return FadeOutUp(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeOutUpBig) {
      return FadeOutUpBig(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeOutLeft) {
      return FadeOutLeft(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeOutLeftBig) {
      return FadeOutLeftBig(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeOutRight) {
      return FadeOutRight(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.fadeOutRightBig) {
      return FadeOutRightBig(
        delay: delay,
        duration: duration,
        child: child,
      );
    }

    if (type == FastAnimateType.bounceInDown) {
      return BounceInDown(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.bounceInUp) {
      return BounceInUp(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.bounceInLeft) {
      return BounceInLeft(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.bounceInRight) {
      return BounceInRight(
        delay: delay,
        duration: duration,
        child: child,
      );
    }

    if (type == FastAnimateType.elasticIn) {
      return ElasticIn(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.elasticInDown) {
      return ElasticInDown(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.elasticInUp) {
      return ElasticInUp(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.elasticInLeft) {
      return ElasticInLeft(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.elasticInRight) {
      return ElasticInRight(
        delay: delay,
        duration: duration,
        child: child,
      );
    }

    if (type == FastAnimateType.slideInDown) {
      return SlideInDown(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.slideInUp) {
      return SlideInUp(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.slideInLeft) {
      return SlideInLeft(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.slideInRight) {
      return SlideInRight(
        delay: delay,
        duration: duration,
        child: child,
      );
    }

    if (type == FastAnimateType.flipInX) {
      return FlipInX(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.flipInY) {
      return FlipInY(
        delay: delay,
        duration: duration,
        child: child,
      );
    }

    if (type == FastAnimateType.zoomIn) {
      return ZoomIn(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.zoomOut) {
      return ZoomOut(
        delay: delay,
        duration: duration,
        child: child,
      );
    }

    if (type == FastAnimateType.jelloIn) {
      return JelloIn(
        delay: delay,
        duration: duration,
        child: child,
      );
    }

    if (type == FastAnimateType.bounce) {
      return Bounce(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.flash) {
      return Flash(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.pulse) {
      return Pulse(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.swing) {
      return Swing(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.spin) {
      return Spin(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.spinPerfect) {
      return SpinPerfect(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.dance) {
      return Dance(
        delay: delay,
        duration: duration,
        child: child,
      );
    }
    if (type == FastAnimateType.roulette) {
      return Roulette(
        delay: delay,
        duration: duration,
        child: child,
      );
    }

    return child;
  }
}
