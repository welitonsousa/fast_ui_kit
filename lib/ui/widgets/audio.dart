import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

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
///   url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
/// )
class FastAudio extends StatefulWidget {
  final String? url;
  final String? asset;
  final Uint8List? bytes;
  final File? file;
  final bool disposeWhenExitScreen;
  final bool showVelocityButton;
  final bool animatePlayerButton;
  final bool showProgressBar;

  /// FastAudio
  ///
  /// example:
  ///
  /// ```dart
  ///  FastAudio(
  ///   url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  /// )
  /// ```
  const FastAudio({
    super.key,
    this.url,
    this.asset,
    this.bytes,
    this.file,
    this.disposeWhenExitScreen = true,
    this.showProgressBar = true,
    this.showVelocityButton = true,
    this.animatePlayerButton = true,
  }) : assert(url != null || asset != null || bytes != null || file != null);

  @override
  State<FastAudio> createState() => _FastAudioState();
}

class _FastAudioState extends State<FastAudio> {
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    AudioLogger.logLevel = AudioLogLevel.none;
    if (widget.url != null) {
      player.setSourceUrl(widget.url!);
    } else if (widget.asset != null) {
      player.setSourceAsset(widget.asset!);
    } else if (widget.bytes != null) {
      player.setSourceBytes(widget.bytes!);
    } else if (widget.file != null) {
      player.setSourceDeviceFile(widget.file!.path);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.disposeWhenExitScreen) {
      player.stop().then((v) => player.dispose());
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PlayerWidget(
          player: player,
          showProgressBar: widget.showProgressBar,
          disposeWhenExitScreen: widget.disposeWhenExitScreen,
          showVelocityButton: widget.showVelocityButton,
          animatePlayerButton: widget.animatePlayerButton,
        ),
      ],
    );
  }
}

class _PlayerWidget extends StatefulWidget {
  final AudioPlayer player;
  final bool showVelocityButton;
  final bool disposeWhenExitScreen;
  final bool animatePlayerButton;
  final bool showProgressBar;

  const _PlayerWidget({
    required this.player,
    required this.disposeWhenExitScreen,
    required this.showVelocityButton,
    required this.animatePlayerButton,
    required this.showProgressBar,
  });

  @override
  State<StatefulWidget> createState() {
    return __PlayerWidgetState();
  }
}

class __PlayerWidgetState extends State<_PlayerWidget> {
  PlayerState? _playerState;
  VelocityEnum velocity = VelocityEnum.x1;
  Duration _duration = const Duration();
  Duration _position = const Duration();

  StreamSubscription<dynamic>? _durationSubscription;
  StreamSubscription<dynamic>? _positionSubscription;
  StreamSubscription<dynamic>? _playerCompleteSubscription;
  StreamSubscription<dynamic>? _playerStateChangeSubscription;

  String get _durationText => _duration.toString().split('.')[0].substring(2);
  String get _positionText => _position.toString().split('.')[0].substring(2);
  AudioPlayer get player => widget.player;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _start();
      _initStreams();
    });
    super.initState();
  }

  Future<void> _start() async {
    _playerState = player.state;
    final res = await Future.wait([
      player.getDuration(),
      player.getCurrentPosition(),
    ]);

    if (res[0] != null) _duration = res[0]!;
    if (res[1] != null) _position = res[1]!;
  }

  @override
  void dispose() {
    if (widget.disposeWhenExitScreen) {
      _durationSubscription?.cancel();
      _positionSubscription?.cancel();
      _playerCompleteSubscription?.cancel();
      _playerStateChangeSubscription?.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_playerState != PlayerState.playing)
              FastAnimate(
                type: widget.animatePlayerButton
                    ? FastAnimateType.spin
                    : FastAnimateType.none,
                duration: const Duration(milliseconds: 500),
                child: IconButton(
                  onPressed: _play,
                  iconSize: 30.0,
                  icon: const Icon(Icons.play_arrow),
                  color: context.colors.primary,
                ),
              ),
            if (_playerState == PlayerState.playing)
              FastAnimate(
                type: widget.animatePlayerButton
                    ? FastAnimateType.dance
                    : FastAnimateType.none,
                duration: const Duration(milliseconds: 500),
                child: IconButton(
                  onPressed: _pause,
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
                          final duration = _duration;

                          final position = v * duration.inMilliseconds;
                          player.seek(Duration(milliseconds: position.round()));
                        },
                        value: (_position.inMilliseconds > 0 &&
                                _position.inMilliseconds <
                                    _duration.inMilliseconds)
                            ? _position.inMilliseconds /
                                _duration.inMilliseconds
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
            if (widget.showVelocityButton)
              ChoiceChip(
                selected: false,
                padding: EdgeInsets.zero,
                backgroundColor: context.button.primaryContainer,
                side: BorderSide(color: context.colors.primary),
                pressElevation: 10,
                onSelected: (v) {
                  velocity = velocity.next();
                  if (player.state != PlayerState.playing) {
                    player.setPlaybackRate(velocity.value);
                    player.pause();
                  } else {
                    player.setPlaybackRate(velocity.value);
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

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription =
        player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _play() async {
    final position = _position;
    if (position.inMilliseconds > 0) {
      await player.seek(position);
    }
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }
}
