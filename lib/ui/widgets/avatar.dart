import 'package:fast_ui_kit/ui/widgets/img.dart';
import 'package:flutter/material.dart';

/// use this widget to show a avatar
///
/// example:
///
/// ```dart
///  FastAvatar(
///   path: 'https://avatars.githubusercontent.com/u/13901776?v=4',
/// ),
class FastAvatar extends StatelessWidget {
  final FastImgType type;
  final String path;
  final double height;
  final double width;

  /// use this widget to show a avatar
  ///
  /// example:
  ///
  /// ```dart
  ///  FastAvatar(
  ///   path: 'https://avatars.githubusercontent.com/u/13901776?v=4',
  /// ),
  /// ```
  const FastAvatar({
    super.key,
    required this.path,
    this.type = FastImgType.network,
    this.height = 60,
    this.width = 60,
  });

  @override
  Widget build(BuildContext context) {
    return FastImg(
      path: path,
      radius: 1000,
      height: height,
      width: width,
      boxFit: BoxFit.cover,
      type: type,
    );
  }
}
