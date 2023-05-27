import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class FastSkeleton extends StatelessWidget {
  final double height;
  final double radius;
  final EdgeInsetsGeometry padding;
  const FastSkeleton({
    super.key,
    this.height = 50,
    this.radius = 10,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Skeleton(
      isLoading: true,
      skeleton: SkeletonLine(
        style: SkeletonLineStyle(
          height: height,
          padding: padding,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
      ),
      child: const SizedBox.shrink(),
    );
  }
}
