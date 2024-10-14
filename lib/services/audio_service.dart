import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
export 'package:audioplayers/audioplayers.dart';

/// use this service to play audio from url
///
/// example:
///
/// ```dart
/// final id = await FastAudioService.i.play('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
/// ```

enum AudioStatus { playing, paused }

class AudioState {
  final AudioStatus status;
  final Duration duration;
  final Duration position;
  final double velocity;
  final String? audioId;

  AudioState({
    required this.status,
    required this.duration,
    required this.position,
    required this.velocity,
    required this.audioId,
  });

  AudioState copyWith({
    AudioStatus? status,
    Duration? duration,
    Duration? position,
    double? velocity,
    String? audioId,
  }) {
    return AudioState(
      status: status ?? this.status,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      velocity: velocity ?? this.velocity,
      audioId: audioId ?? this.audioId,
    );
  }
}

class FastAudioService {
  FastAudioService._();
  static FastAudioService? _instance;

  static FastAudioService get i {
    _instance ??= FastAudioService._();
    return _instance!;
  }

  static AudioPlayer? _audio;
  static AudioState? _state;

  static Source getSource(String url, {bool isFile = false}) {
    if (url.contains('http')) return UrlSource(url);
    if (isFile) {
      return DeviceFileSource(url);
    }
    return AssetSource(url);
  }

  AudioPlayer? get audio => _audio;

  Future<void> play(AudioPlayer player) async {
    if (Platform.isAndroid) {
      final cxt = AudioContext(
        android: const AudioContextAndroid(
          isSpeakerphoneOn: true,
          stayAwake: true,
          audioFocus: AndroidAudioFocus.none,
        ),
      );
      await player.setAudioContext(cxt);
    }
    if (player.source.toString() != _audio?.source.toString()) {
      await _audio?.stop();
    }
    player.setVolume(1);
    await player.resume();
    _audio = player;
    _state = AudioState(
      status: AudioStatus.playing,
      duration: const Duration(),
      position: const Duration(),
      velocity: 1,
      audioId: player.source.toString(),
    );
  }

  Future<void> resume(AudioPlayer player) async {
    _state = _state?.copyWith(status: AudioStatus.playing);
    await player.resume();
  }

  Future<void> pause(AudioPlayer player) async {
    _state = _state?.copyWith(status: AudioStatus.paused);
    await player.pause();
  }

  Future<void> pauseResume(AudioPlayer player) async {
    if (_state?.status == AudioStatus.playing) {
      _state = _state?.copyWith(status: AudioStatus.paused);
      await player.pause();
    } else {
      _state = _state?.copyWith(status: AudioStatus.playing);
      await player.resume();
    }
  }

  Future<void> stop(AudioPlayer player) async {
    _state = null;
    _audio = null;
    await player.seek(const Duration());
    await player.stop();
  }

  // Future<void> complete(AudioPlayer player) async {
  //   await player.seek(const Duration());
  //   _state = null;
  //   _audio = null;
  // }

  Future<void> velocity(AudioPlayer player, double v) async {
    _state = _state?.copyWith(velocity: v);
    await player.setPlaybackRate(v);
  }

  Future<void> seek(AudioPlayer player, Duration position) async {
    _state = _state?.copyWith(position: position);
    await player.seek(position);
  }

  Future<Duration?> duration(AudioPlayer player) => player.getDuration();
  Future<Duration?> position(AudioPlayer player) => player.getCurrentPosition();
}
