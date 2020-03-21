import 'package:podcast_alarm/api/api_client.dart';

class Podcast implements Codable {
  static const String cacheFilename = "podcast.json";

  String audio;
  int audio_length_sec;
  String rss;
  String description_highlighted;
  String description_original;
  String title_highlighted;
  String title_original;
  String podcast_title_highlighted;
  String podcast_title_original;
  String publisher_highlighted;
  String publisher_original;
  String image;
  String thumbnail;
  int itunes_id;
  int pub_date_ms;
  String id;
  String podcast_id;
  List<dynamic> genre_ids;
  String listennotes_url;
  String podcast_listennotes_url;
  bool explicit_content;
  String link;

  Podcast.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];
    audio_length_sec = json['audio_length_sec'];
    rss = json['rss'];
    description_highlighted = json['description_highlighted'];
    description_original = json['description_original'];
    title_highlighted = json['title_highlighted'];
    title_original = json['title_original'];
    podcast_title_highlighted = json['podcast_title_highlighted'];
    podcast_title_original = json['podcast_title_original'];
    publisher_highlighted = json['publisher_highlighted'];
    publisher_original = json['publisher_original'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    itunes_id = json['itunes_id'];
    pub_date_ms = json['pub_date_ms'];
    id = json['id'];
    podcast_id = json['podcast_id'];
    genre_ids = json['genre_ids'];
    listennotes_url = json['listennotes_url'];
    podcast_listennotes_url = json['podcast_listennotes_url'];
    explicit_content = json['explicit_content'];
    link = json['link'];
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
    return data;
  }

  @override
  Codable fromJson(Map<String, dynamic> json) {
    return Podcast.fromJson(json);
  }
}
