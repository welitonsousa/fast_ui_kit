import 'dart:async';
import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:fast_ui_kit/utils/enum/velocity.dart';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';

/// FastAudio2
///
/// example:
///
/// ```dart
///  FastAudio2(
///   url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
/// )
///
///

class FastAudio2 extends StatefulWidget {
  static void initialize() {
    WidgetsFlutterBinding.ensureInitialized();
    MediaKit.ensureInitialized();
  }

  final String url;
  final bool animatePlayerButton;
  const FastAudio2({
    super.key,
    required this.url,
    this.animatePlayerButton = true,
  });

  @override
  State<FastAudio2> createState() => _FastAudio2State();
}

class _FastAudio2State extends State<FastAudio2> {
  final player = Player();

  VelocityEnum velocity = VelocityEnum.x1;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  StreamSubscription<dynamic>? _durationSubscription;
  StreamSubscription<dynamic>? _positionSubscription;
  StreamSubscription<dynamic>? _playerCompleteSubscription;
  StreamSubscription<dynamic>? _playerStateChangeSubscription;

  String get _durationText => _duration.toString().split('.')[0].substring(2);
  String get _positionText => _position.toString().split('.')[0].substring(2);

  @override
  void initState() {
    super.initState();
    player.open(Media(widget.url), play: false);
    _initStreams();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  void _initStreams() {
    player.stream.duration.listen((event) {
      setState(() {
        _duration = event;
      });
    });
    player.stream.position.listen((event) {
      setState(() {
        _position = event;
      });
    });
    player.stream.playing.listen((event) {
      setState(() {});
    });
    player.stream.completed.listen((event) {
      setState(() {
        if (event) {
          player.seek(const Duration()).then((value) => player.pause());
        }
      });
    });
  }

  Future<void> _play() async {
    await player.playOrPause();
  }

  Future<void> _pause() async {
    await player.playOrPause();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!player.state.playing)
          FastAnimate(
            type: widget.animatePlayerButton
                ? FastAnimateType.spin
                : FastAnimateType.none,
            child: IconButton(
              onPressed: _play,
              iconSize: 30.0,
              icon: const Icon(Icons.play_arrow),
              color: context.colors.primary,
            ),
          ),
        if (player.state.playing)
          FastAnimate(
            type: widget.animatePlayerButton
                ? FastAnimateType.dance
                : FastAnimateType.none,
            child: IconButton(
              onPressed: _pause,
              iconSize: 30.0,
              icon: const Icon(Icons.pause),
              color: context.colors.primary,
            ),
          ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Slider(
                  onChanged: (v) {
                    final duration = _duration;
                    final position = v * duration.inMilliseconds;
                    player.seek(Duration(milliseconds: position.round()));
                  },
                  value: (_position.inMilliseconds > 0)
                      ? _position.inMilliseconds / _duration.inMilliseconds
                      : 0.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_positionText),
                    Text(_durationText),
                  ],
                ),
              ),
            ],
          ),
        ),
        ChoiceChip(
          selected: false,
          padding: EdgeInsets.zero,
          backgroundColor: context.button.primaryContainer,
          side: BorderSide(color: context.colors.primary),
          pressElevation: 10,
          onSelected: (v) {
            velocity = velocity.next();
            player.setRate(velocity.value);
          },
          label: SizedBox(
            width: 30,
            child: Center(child: Text(velocity.name)),
          ),
        ),
      ],
    );
  }
}
