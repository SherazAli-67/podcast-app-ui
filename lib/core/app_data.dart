import 'package:podcast_app_ui/core/asset_res.dart';
import 'package:podcast_app_ui/core/models/album_model.dart';
import 'package:podcast_app_ui/core/models/episode_model.dart';
import 'package:podcast_app_ui/core/models/mood_genre_model.dart';
import 'package:podcast_app_ui/core/models/story_model.dart';
import 'package:podcast_app_ui/core/models/track_model.dart';

class AppData {
  static const stories = [
    StoryModel(image: AssetRes.storyTwentyOnePilots, title: 'twenty one pilots'),
    StoryModel(image: AssetRes.storyArRahman, title: 'A.R Rahman'),
    StoryModel(image: AssetRes.storyLinkinPark, title: 'Linkin Park'),
    StoryModel(image: AssetRes.storyBlurryface, title: 'twenty one pilots'),
  ];

  static const recentlyPlayed = [
    AlbumModel(cover: AssetRes.albumDawnFm, title: 'Dawn FM'),
    AlbumModel(cover: AssetRes.albumTrench, title: 'Trench'),
    AlbumModel(cover: AssetRes.albumGangsOfWasseypur, title: 'Gangs of Wasseypur - 2'),
    AlbumModel(cover: AssetRes.albumDawnFm, title: 'Dawn FM'),
  ];

  static const moodsAndGenres = [
    MoodGenreModel(cover: AssetRes.moodListening),
    MoodGenreModel(cover: AssetRes.moodPlaying),
    MoodGenreModel(cover: AssetRes.moodHeadphone),
  ];

  static const nowPlaying = TrackModel(
    cover: AssetRes.playerStarboy,
    title: 'Take My Breath',
    artist: 'The Weeknd',
  );

  static const popularEpisodes = [
    EpisodeModel(
      cover: AssetRes.episodeNature1,
      title: 'Enjoy The Nature',
      author: 'Webby',
      episodeLabel: 'Episode 01',
    ),
    EpisodeModel(
      cover: AssetRes.episodeNature2,
      title: 'Enjoy The Nature',
      author: 'Webby',
      episodeLabel: 'Episode 01',
    ),
    EpisodeModel(
      cover: AssetRes.episodeNature3,
      title: 'Enjoy The Nature',
      author: 'Webby',
      episodeLabel: 'Episode 01',
    ),
    EpisodeModel(
      cover: AssetRes.episodeNature4,
      title: 'Enjoy The Nature',
      author: 'Webby',
      episodeLabel: 'Episode 01',
    ),
    EpisodeModel(
      cover: AssetRes.episodeNature5,
      title: 'Enjoy The Nature',
      author: 'Webby',
      episodeLabel: 'Episode 01',
    ),
    EpisodeModel(
      cover: AssetRes.episodeNature5,
      title: 'Enjoy The Nature',
      author: 'Webby',
      episodeLabel: 'Episode 01',
    ),
    EpisodeModel(
      cover: AssetRes.episodeNature4,
      title: 'Enjoy The Nature',
      author: 'Webby',
      episodeLabel: 'Episode 01',
    ),
    EpisodeModel(
      cover: AssetRes.episodeNature6,
      title: 'Enjoy The Nature',
      author: 'Webby',
      episodeLabel: 'Episode 01',
      isActive: true,
    ),
  ];
}
