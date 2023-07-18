class YogaVideo {
  final String link;
  final int? duration;
  final String name;
  final String? description;

  YogaVideo(
      {required this.link,
      this.duration,
      required this.name,
      this.description});

  factory YogaVideo.fromJson(Map<String, dynamic> json) {
    return YogaVideo(
        link: json['link'] ?? '',
        duration: json['duration'] ?? 0,
        name: json['name'] ?? '',
        description: json['description'] ?? '');
  }
}
