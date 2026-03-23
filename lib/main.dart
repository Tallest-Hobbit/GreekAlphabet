import 'package:flutter/material.dart';
import 'screens/image_swiper_page.dart';

void main() {
  runApp(const ImageSoundSwiperApp());
}

class ImageSoundSwiperApp extends StatelessWidget {
  const ImageSoundSwiperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Sound Swiper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ImageSwiperPage(),
    );
  }
}