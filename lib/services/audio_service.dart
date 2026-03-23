import 'package:audioplayers/audioplayers.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playAsset(String fullAssetPath) async {
    try {
      await _player.stop();

      // audioplayers AssetSource expects the path relative to assets/
      final relativePath = fullAssetPath.replaceFirst('assets/', '');

      await _player.play(AssetSource(relativePath));
    } catch (_) {
      rethrow;
    }
  }

  Future<void> dispose() async {
    await _player.dispose();
  }
}