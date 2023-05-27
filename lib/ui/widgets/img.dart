import 'dart:io';

import 'package:fast_ui_kit/ui/widgets/skeleton.dart';
import 'package:flutter/material.dart';

enum FastImgType { network, asset, file }

class FastImg extends StatelessWidget {
  final String path;
  final FastImgType type;
  final Widget? error;
  final double? width;
  final double? height;
  final BoxFit? boxFit;
  final double radius;

  const FastImg({
    super.key,
    this.error,
    required this.path,
    this.type = FastImgType.network,
    this.height,
    this.width,
    this.boxFit,
    this.radius = 10,
  });

  Widget Function(BuildContext, Object, StackTrace?)? get errorBuilder {
    if (error != null) return (_, __, ___) => error!;
    return null;
  }

  Widget Function(BuildContext, Widget, ImageChunkEvent?) get loader {
    return (_, child, loadingProgress) {
      if (loadingProgress == null) return child;

      return LayoutBuilder(builder: (context, constrains) {
        return FastSkeleton(
          radius: radius,
          height: height ?? constrains.maxHeight,
        );
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    if (type == FastImgType.asset) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(
          path,
          fit: boxFit,
          errorBuilder: errorBuilder,
          height: height,
          width: width,
        ),
      );
    }
    if (type == FastImgType.file) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.file(
          File(path),
          fit: boxFit,
          errorBuilder: errorBuilder,
          height: height,
          width: width,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        path,
        fit: boxFit,
        errorBuilder: errorBuilder,
        loadingBuilder: loader,
        height: height,
        width: width,
      ),
    );
  }
}
