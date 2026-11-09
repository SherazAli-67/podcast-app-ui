class EpisodeModel {
  final String cover;
  final String title;
  final String author;
  final String episodeLabel;
  final bool isActive;

  const EpisodeModel({
    required this.cover,
    required this.title,
    required this.author,
    required this.episodeLabel,
    this.isActive = false,
  });
}
