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

  static FastAudioService get i {
    _instance ??= FastAudioService._();
    return _instance!;
  }

  final player = AudioPlayer();

  Future<String> play(String url, {String? id}) async {
    await player.setSourceUrl(url);
    _audioId = DateTime.now().toIso8601String();
    player.resume();
    return _audioId!;
  }

  Future<Duration?> get duration => player.getDuration();
  Future<Duration?> get position => player.getCurrentPosition();

  Future<void> resume() => player.resume();
  Future<void> pause() async {
    await player.pause();
    _audioId = null;
  }

  Future<void> stop() async {
    await player.stop();
    _audioId = null;
  }

  Future<void> velocity(double v) => player.setPlaybackRate(v);
  Future<void> seek(Duration position) => player.seek(position);
  Future<void> setVolume(double volume) => player.setVolume(volume);
}
