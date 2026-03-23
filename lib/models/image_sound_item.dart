class ImageSoundItem {
  final String imagePath;
  final String? topSoundPath;
  final String? bottomSoundPath;
  final String? title;

  const ImageSoundItem({
    required this.imagePath,
    this.topSoundPath,
    this.bottomSoundPath,
    this.title,
  });
}