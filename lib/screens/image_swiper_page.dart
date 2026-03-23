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
  String _statusMessage = 'Tap the top or bottom half of the image';

  Future<void> _handleTap(bool isTopHalf) async {
    final item = imageSoundItems[_currentIndex];
    final soundPath = isTopHalf ? item.topSoundPath : item.bottomSoundPath;

    try {
      await _audioService.playAsset(soundPath);

      if (!mounted) return;
      setState(() {
        _statusMessage = isTopHalf
            ? 'Played top sound for ${item.title ?? 'current image'}'
            : 'Played bottom sound for ${item.title ?? 'current image'}';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _statusMessage = 'Failed to play sound: $e';
      });
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
    final currentItem = imageSoundItems[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Sound Swiper'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: imageSoundItems.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                    _statusMessage =
                        'Showing ${imageSoundItems[index].title ?? 'image ${index + 1}'}';
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentItem.title ?? 'Image ${_currentIndex + 1}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text('Image ${_currentIndex + 1} of ${imageSoundItems.length}'),
                  const SizedBox(height: 8),
                  Text(_statusMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}