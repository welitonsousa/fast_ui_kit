import 'dart:async';
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
  final bool isFile;
  final bool showVelocityButton;
  final bool animatePlayerButton;
  final bool showProgressBar;
  final Function(Function()) updateState;
  final bool stopWhenDispose;

  const FastAudio({
    super.key,
    required this.url,
    required this.updateState,
    this.showVelocityButton = true,
    this.animatePlayerButton = true,
    this.showProgressBar = true,
    this.isFile = false,
    this.stopWhenDispose = false,
  });

  @override
  State<StatefulWidget> createState() {
    return _FastAudioState();
  }
}

class _FastAudioState extends State<FastAudio> {
  final fastAudio = FastAudioService.i;
  AudioPlayer audio = AudioPlayer();

  @override
  void initState() {
    audioConfigure(init: true);
    super.initState();
  }

  Future<void> audioConfigure({bool init = false}) async {
    _nextFrame(() async {
      final isFile = widget.isFile;
      final source = FastAudioService.getSource(widget.url, isFile: isFile);
      await audio.setSource(source);
      final res = await audio.getDuration() ?? const Duration();
      setState(() => duration = res);
      if (init) initialize();
    });
  }

  @override
  void dispose() {
    if (audio.state == PlayerState.playing) {
      if (widget.stopWhenDispose) {
        FastAudioService.i.stop(audio).then((value) {
          audio.dispose();
        });
      }
    } else {
      if (FastAudioService.i.audio?.source.toString() ==
          audio.source.toString()) {
        FastAudioService.i.stop(audio).then((_) => audio.dispose());
      } else {
        audio.dispose();
      }
    }
    super.dispose();
  }

  PlayerState get playerState {
    return audio.state;
  }

  VelocityEnum velocity = VelocityEnum.x1;
  Duration duration = const Duration();
  Duration position = const Duration();

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
                  velocity = velocity.next();
                  player.velocity(audio, velocity.value);
                  setState(() {});
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
  void _playTimer() async {
    timer = Timer.periodic(const Duration(milliseconds: 200), (_) async {
      position = (await audio.getCurrentPosition()) ?? const Duration();
      if (!mounted) _.cancel();
      if (playerState == PlayerState.completed) {
        setState(() {});
        _.cancel();
      }
      if (mounted) setState(() {});
    });
  }

  Future<void> initialize() async {
    final res = FastAudioService.i.audio;
    if (res != null && res.source.toString() == audio.source.toString()) {
      audio = res;
      position = await FastAudioService.i.position(audio) ?? const Duration();
      if (audio.state == PlayerState.playing) _playTimer();
      setState(() {});
    }
  }

  Future<void> play() async {
    final source = FastAudioService.getSource(
      widget.url,
      isFile: widget.isFile,
    );
    await audio.setSource(source);
    await FastAudioService.i.play(audio);

    _playTimer();
    setState(() {});
  }

  Future<void> pause() async {
    timer?.cancel();
    await FastAudioService.i.pause(audio);
    setState(() {});
  }

  Future<void> setPosition(double milliseconds) async {
    final position = Duration(milliseconds: milliseconds.round());
    await FastAudioService.i.seek(audio, position);
    _nextFrame(() => setState(() {}));
  }

  void _nextFrame(Function() action) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      action();
    });
  }
}
