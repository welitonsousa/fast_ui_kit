import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

/// A fast carousel widget that displays a horizontally scrollable list of items.

class FastCarousel extends StatelessWidget {
  /// The list of labels to display on top of each item.
  final List<String>? labels;

  /// The number of items in the carousel.
  final int itemCount;

  /// The height of the carousel.
  final double? height;

  /// The scaling factor for each item in the carousel.
  final double scale;

  /// The fraction of the viewport occupied by each item.
  final double fraction;

  /// The duration between automatic item transitions.
  final Duration duration;

  /// The builder function for each item in the carousel.
  final Widget Function(BuildContext, int)? itemBuilder;

  /// Creates a new instance of [FastCarousel].
  ///
  /// The [itemBuilder] and [itemCount] parameters are required.
  /// The [labels], [height], [scale], [duration], and [fraction] parameters are optional.
  ///
  /// ```dart
  /// FastCarousel(
  ///   itemCount: 5,
  ///   height: 200,
  ///   scale: 0.8,
  ///   fraction: 0.7,
  ///   duration: Duration(seconds: 5),
  ///   itemBuilder: (BuildContext context, int index) {
  ///     return FastImg(path: 'https://picsum.photos/200/300?random=$index');
  ///   },
  /// )
  /// ```
  const FastCarousel({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.labels,
    this.height,
    this.scale = 0.9,
    this.duration = const Duration(seconds: 10),
    this.fraction = 0.8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Swiper(
        viewportFraction: fraction,
        scale: scale,
        autoplay: true,
        autoplayDelay: duration.inMilliseconds,
        itemCount: itemCount,
        loop: true,
        allowImplicitScrolling: true,
        control: const SwiperControl(),
        itemHeight: height,
        itemBuilder: (BuildContext context, int i) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: itemBuilder?.call(context, i),
              ),
              if (labels != null && labels!.length >= i)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.5),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Text(labels?[i] ?? ""),
                ),
            ],
          );
        },
      ),
    );
  }
}
