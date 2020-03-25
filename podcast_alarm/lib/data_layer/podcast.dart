import 'package:podcast_alarm/api/api_client.dart';

class Podcast implements Codable {
  static const String cacheFilename = "podcast.json";
  static const String justListen = "just_listen.json";

  String audio;
  int audio_length_sec;
  String rss;
  String description_highlighted;
  String description_original;
  String title_highlighted;
  String title_original;
  String title;
  String podcast_title_highlighted;
  String podcast_title_original;
  String podcast_title;
  String publisher_highlighted;
  String publisher_original;
  String publisher;
  String image;
  String thumbnail;
  int itunes_id;
  int pub_date_ms;
  String id;
  String podcast_id;
  List<dynamic> genre_ids;
  List<dynamic> episodes;
  String listennotes_url;
  String podcast_listennotes_url;
  bool explicit_content;
  String link;

  String get podcastTitle {
    return podcast_title ?? podcast_title_original;
  }

  String get podcastPublisher {
    return publisher ?? publisher_original;
  }

  Podcast.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];
    audio_length_sec = json['audio_length_sec'];
    rss = json['rss'];
    description_highlighted = json['description_highlighted'];
    description_original = json['description_original'];
    title_highlighted = json['title_highlighted'];
    title_original = json['title_original'];
    title = json['title'];
    podcast_title_highlighted = json['podcast_title_highlighted'];
    podcast_title_original = json['podcast_title_original'];
    podcast_title = json['podcast_title'];
    publisher_highlighted = json['publisher_highlighted'];
    publisher_original = json['publisher_original'];
    publisher = json['publisher'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    itunes_id = json['itunes_id'];
    pub_date_ms = json['pub_date_ms'];
    id = json['id'];
    podcast_id = json['podcast_id'];
    if (json['genre_ids'] != null) {
      genre_ids = json['genre_ids'].cast<int>();
    }
    listennotes_url = json['listennotes_url'];
    podcast_listennotes_url = json['podcast_listennotes_url'];
    explicit_content = json['explicit_content'];
    link = json['link'];
    episodes = json['episodes'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['audio'] = this.audio;
    data['audio_length_sec'] = this.audio_length_sec;
    data['description_highlighted'] = this.description_highlighted;
    data['description_original'] = this.description_original;
    data['title_highlighted'] = this.title_highlighted;
    data['title_original'] = this.title_original;
    data['podcast_title_highlighted'] = this.podcast_title_highlighted;
    data['podcast_title_original'] = this.podcast_title_original;
    data['publisher_highlighted'] = this.publisher_highlighted;
    data['image'] = this.image;
    data['thumbnail'] = this.thumbnail;
    data['pub_date_ms'] = this.pub_date_ms;
    data['id'] = this.id;
    data['itunes_id'] = this.itunes_id;
    data['genre_ids'] = this.genre_ids;
    data['listennotes_url'] = this.listennotes_url;
    data['podcast_listennotes_url'] = this.podcast_listennotes_url;
    data['listennotes_url'] = this.listennotes_url;
    data['explicit_content'] = this.explicit_content;
    data['link'] = this.link;
    data['podcast_title'] = this.podcast_title;
    data['title'] = this.title;
    data['publisher'] = this.publisher;
    return data;
  }

  @override
  Codable fromJson(Map<String, dynamic> json) {
    return Podcast.fromJson(json);
  }
}
