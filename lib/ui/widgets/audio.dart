import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:fast_ui_kit/utils/enum/velocity.dart';
import 'package:flutter/material.dart';

/// FastAudio
///
/// example:
///
/// ```dart
///  FastAudio(
///   updateState: setState,
///   url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
/// )
/// ```

class FastAudio extends StatefulWidget {
  final String url;
  final bool showVelocityButton;
  final bool animatePlayerButton;
  final bool showProgressBar;
  final Function(Function()) updateState;

  const FastAudio({
    super.key,
    required this.url,
    this.showVelocityButton = true,
    this.animatePlayerButton = true,
    this.showProgressBar = true,
    required this.updateState,
  });

  @override
  State<StatefulWidget> createState() {
    return _FastAudioState();
  }
}

class _FastAudioState extends State<FastAudio> {
  PlayerState get playerState {
    final audio = FastAudioService.i;
    if (audio.audioId != audioId) return PlayerState.stopped;
    return FastAudioService.i.player.state;
  }

  VelocityEnum velocity = VelocityEnum.x1;
  Duration duration = const Duration();
  Duration position = const Duration();
  String? audioId;

  StreamSubscription<dynamic>? durationSubscription;
  StreamSubscription<dynamic>? positionSubscription;
  StreamSubscription<dynamic>? playerCompleteSubscription;
  StreamSubscription<dynamic>? playerStateChangeSubscription;

  String get durationText => duration.toString().split('.')[0].substring(2);
  String get positionText => position.toString().split('.')[0].substring(2);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (playerState != PlayerState.playing)
              FastAnimate(
                type: widget.animatePlayerButton
                    ? FastAnimateType.spin
                    : FastAnimateType.none,
                duration: const Duration(milliseconds: 500),
                child: IconButton(
                  onPressed: play,
                  iconSize: 30.0,
                  icon: const Icon(Icons.play_arrow),
                  color: context.colors.primary,
                ),
              ),
            if (playerState == PlayerState.playing)
              FastAnimate(
                type: widget.animatePlayerButton
                    ? FastAnimateType.dance
                    : FastAnimateType.none,
                duration: const Duration(milliseconds: 500),
                child: IconButton(
                  onPressed: pause,
                  iconSize: 30.0,
                  icon: const Icon(Icons.pause),
                  color: context.colors.primary,
                ),
              ),
            if (widget.showProgressBar)
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Slider(
                        onChanged: (v) {
                          setPosition(v * duration.inMilliseconds);
                        },
                        value: (position.inMilliseconds > 0 &&
                                position.inMilliseconds <
                                    duration.inMilliseconds)
                            ? position.inMilliseconds / duration.inMilliseconds
                            : 0.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(positionText),
                          Text(durationText),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.showVelocityButton)
              ChoiceChip(
                selected: false,
                padding: EdgeInsets.zero,
                backgroundColor: context.button.primaryContainer,
                side: BorderSide(color: context.colors.primary),
                pressElevation: 10,
                onSelected: (v) {
                  final player = FastAudioService.i;
                  if (player.audioId != audioId) return;

                  velocity = velocity.next();
                  if (player.player.state != PlayerState.playing) {
                    player.velocity(velocity.value);
                    player.pause();
                  } else {
                    player.velocity(velocity.value);
                  }
                },
                label: SizedBox(
                  width: 30,
                  child: Center(child: Text(velocity.name)),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Timer? timer;
  void _playTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      position = await FastAudioService.i.player.getCurrentPosition() ??
          const Duration();
      if (mounted) setState(() {});
      if (FastAudioService.i.audioId != audioId) timer.cancel();
      if (position.inMilliseconds >= duration.inMilliseconds) {
        timer.cancel();
        _nextFrame(() => setState(() {}));
      }
    });
  }

  Future<void> _getDuration() async {
    if (this.duration != const Duration()) return;
    final duration = await FastAudioService.i.duration;
    this.duration = duration ?? const Duration();
  }

  Future<void> play() async {
    final id = await FastAudioService.i.play(widget.url, id: audioId);
    audioId = id;
    _getDuration();
    _playTimer();
    _nextFrame(() => widget.updateState(() {}));
  }

  Future<void> pause() async {
    await FastAudioService.i.pause();
    timer?.cancel();
    _nextFrame(() => setState(() {}));
  }

  Future<void> setPosition(double milliseconds) async {
    if (audioId != FastAudioService.i.audioId) return;
    final position = Duration(milliseconds: milliseconds.round());
    await FastAudioService.i.seek(position);
    _nextFrame(() => setState(() {}));
  }

  void _nextFrame(Function() action) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      action();
    });
  }
}
