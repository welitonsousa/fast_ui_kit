import 'package:audioplayers/audioplayers.dart';

/// use this service to play audio from url
///
/// example:
///
/// ```dart
/// final id = await FastAudioService.i.play('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
/// ```
class FastAudioService {
  FastAudioService._();
  static FastAudioService? _instance;

  String? _audioId;
  String? get audioId => _audioId;

  static get i {
    _instance ??= FastAudioService._();
    return _instance!;
  }

  final player = AudioPlayer();

  Future<String> play(String url) async {
    await player.setSourceUrl(url);
    _audioId = DateTime.now().toIso8601String();
    player.resume();
    return _audioId!;
  }

  Future<void> resume() => player.resume();
  Future<void> pause() => player.pause();
  Future<void> stop() => player.stop();
  Future<void> seek(Duration position) => player.seek(position);
  Future<void> setVolume(double volume) => player.setVolume(volume);
}
