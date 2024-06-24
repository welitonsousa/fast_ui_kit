import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FastSkeleton extends StatelessWidget {
  final double height;
  final double radius;
  final EdgeInsetsGeometry padding;

  /// Creates a widget that shows a skeleton.
  ///
  /// ```dart
  /// const FastSkeleton(
  ///   height: 50,
  ///   radius: 10,
  ///   padding: EdgeInsets.zero,
  /// );
  /// ```
  const FastSkeleton({
    super.key,
    this.height = 50,
    this.radius = 10,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: const SizedBox(),
      ),
    );
  }
}
