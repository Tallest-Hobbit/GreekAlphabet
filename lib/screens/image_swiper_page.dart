import 'package:flutter/material.dart';

import '../data/image_sound_data.dart';
import '../services/audio_service.dart';
import '../widgets/tappable_image_view.dart';

class ImageSwiperPage extends StatefulWidget {
  const ImageSwiperPage({super.key});

  @override
  State<ImageSwiperPage> createState() => _ImageSwiperPageState();
}

class _ImageSwiperPageState extends State<ImageSwiperPage> {
  final PageController _pageController = PageController();
  final AudioService _audioService = AudioService();

  int _currentIndex = 0;

  Future<void> _handleTap(bool isTopHalf) async {
    final item = imageSoundItems[_currentIndex];
    final String? soundPath =
        isTopHalf ? item.topSoundPath : item.bottomSoundPath;

    if (soundPath == null) return;

    try {
      await _audioService.playAsset(soundPath);
    } catch (e) {
      debugPrint('Failed to play sound: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _pageController,
          itemCount: imageSoundItems.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: TappableImageView(
                imagePath: imageSoundItems[index].imagePath,
                onTapHalf: (isTopHalf) async {
                  if (_currentIndex != index) return;
                  await _handleTap(isTopHalf);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}