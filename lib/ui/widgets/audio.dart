import 'dart:async';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FastAudio extends StatefulWidget {
  final String? url;
  final String? asset;
  final Uint8List? bytes;
  const FastAudio({super.key, this.url, this.asset, this.bytes})
      : assert(url != null || asset != null || bytes != null);

  @override
  State<FastAudio> createState() => _FastAudioState();
}

class _FastAudioState extends State<FastAudio> {
  final AudioPlayer player = AudioPlayer(playerId: const Uuid().v1());

  @override
  void initState() {
    if (widget.url != null) player.setSourceUrl(widget.url!);
    if (widget.asset != null) player.setSourceAsset(widget.asset!);
    if (widget.bytes != null) player.setSourceBytes(widget.bytes!);

    super.initState();
  }

  @override
  void dispose() {
    player.stop().then((v) => player.dispose());
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PlayerWidget(player: player),
      ],
    );
  }
}

class _PlayerWidget extends StatefulWidget {
  final AudioPlayer player;

  const _PlayerWidget({
    required this.player,
  });

  @override
  State<StatefulWidget> createState() {
    return __PlayerWidgetState();
  }
}

enum Velocity {
  x1,
  x1_5,
  x2;

  String get name {
    if (this == Velocity.x1_5) return '1,5x';
    if (this == Velocity.x2) return '2x';
    return '1x';
  }

  Velocity next() {
    if (this == Velocity.x1) return Velocity.x1_5;
    if (this == Velocity.x1_5) return Velocity.x2;
    return Velocity.x1;
  }

  double get value {
    if (this == Velocity.x1_5) return 1.5;
    if (this == Velocity.x2) return 2;
    return 1;
  }
}

class __PlayerWidgetState extends State<_PlayerWidget> {
  PlayerState? _playerState;
  Velocity velocity = Velocity.x1;
  Duration? _duration;
  Duration? _position;

  StreamSubscription<dynamic>? _durationSubscription;
  StreamSubscription<dynamic>? _positionSubscription;
  StreamSubscription<dynamic>? _playerCompleteSubscription;
  StreamSubscription<dynamic>? _playerStateChangeSubscription;

  String get _durationText => _duration?.toString().split('.').first ?? '';
  String get _positionText => _position?.toString().split('.').first ?? '';

  AudioPlayer get player => widget.player;

  @override
  void initState() {
    super.initState();
    _start();
    _initStreams();
  }

  Future<void> _start() async {
    _playerState = player.state;
    final res = await Future.wait([
      player.getDuration(),
      player.getCurrentPosition(),
    ]);
    _duration = res[0];
    _position = res[1];
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
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
                type: FastAnimateType.spin,
                duration: const Duration(milliseconds: 500),
                child: IconButton(
                  key: const Key('play_button'),
                  onPressed: _play,
                  iconSize: 30.0,
                  icon: const Icon(Icons.play_arrow),
                  color: context.colors.primary,
                ),
              ),
            if (_playerState == PlayerState.playing)
              FastAnimate(
                type: FastAnimateType.dance,
                duration: const Duration(milliseconds: 500),
                child: IconButton(
                  key: const Key('pause_button'),
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
                        if (duration == null) return;

                        final position = v * duration.inMilliseconds;
                        player.seek(Duration(milliseconds: position.round()));
                      },
                      value: (_position != null &&
                              _duration != null &&
                              _position!.inMilliseconds > 0 &&
                              _position!.inMilliseconds <
                                  _duration!.inMilliseconds)
                          ? _position!.inMilliseconds /
                              _duration!.inMilliseconds
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
    if (position != null && position.inMilliseconds > 0) {
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
