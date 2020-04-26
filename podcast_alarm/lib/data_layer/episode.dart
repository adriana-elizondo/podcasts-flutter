import 'package:podcast_alarm/api/api_client.dart';

class Episode implements Codable {
  static const String cacheFilename = "episode.json";

  String id;
  String podcast_id;
  String link;
  String audio;
  String image;
  String title;
  String thumbnail;
  String description;
  int pub_date_ms;
  String listennotes_url;
  int audio_length_sec;
  bool explicit_content;
  bool maybe_audio_invalid;
  String listennotes_edit_url;

  Episode.fromJson(Map<String, dynamic> json){
    id = json['id'];
    link = json['email'];
    audio = json['audio'];
    image = json['image'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    description = json['description'];
    pub_date_ms = json['pub_date_ms'];
    listennotes_url = json['listennotes_url'];
    audio_length_sec = json['audio_length_sec'];
    explicit_content = json['explicit_content'];
    maybe_audio_invalid = json['maybe_audio_invalid'];
    listennotes_edit_url = json['listennotes_edit_url'];
  }

  @override
  Codable fromJson(Map<String, dynamic> json) {
    return Episode.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['link'] = this.link;
    data['audio'] = this.audio;
    data['image'] = this.image;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['description'] = this.description;
    data['pub_date_ms'] = this.pub_date_ms;
    data['listennotes_url'] = this.listennotes_url;
    data['audio_length_sec'] = this.audio_length_sec;
    data['explicit_content'] = this.explicit_content;
    data['maybe_audio_invalid'] = this.maybe_audio_invalid;
    data['listennotes_edit_url'] = this.listennotes_edit_url;
    return data;
  }
}
