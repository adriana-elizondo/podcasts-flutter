import 'package:podcast_alarm/api/api_client.dart';

class PodcastExtra implements Codable {
  String url1;
  String url2;
  String url3;
  String google_url;
  String spotify_url;
  String youtube_url;
  String linkedin_url;
  String wechat_handle;
  String patreon_handle;
  String twitter_handle;
  String facebook_handle;
  String instagram_handle;

  PodcastExtra.fromJson(Map<String, dynamic> json) {
    this.url1 = json["url1"];
    this.url2 = json["url2"];
    this.url3 = json["url3"];
    this.google_url = json["google_url"];
    this.spotify_url = json["spotify_url"];
    this.youtube_url = json["youtube_url"];
    this.linkedin_url = json["linkedin_url"];
    this.wechat_handle = json["wechat_handle"];
    this.patreon_handle = json["patreon_handle"];
    this.twitter_handle = json["twitter_handle"];
    this.facebook_handle = json["facebook_handle"];
    this.instagram_handle = json["instagram_handle"];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['url1'] = this.url1;
    data['url2'] = this.url2;
    data['url3'] = this.url3;
    data['google_url'] = this.google_url;
    data['spotify_url'] = this.spotify_url;
    data['youtube_url'] = this.youtube_url;
    data['linkedin_url'] = this.linkedin_url;
    data['wechat_handle'] = this.wechat_handle;
    data['patreon_handle'] = this.patreon_handle;
    data['twitter_handle'] = this.twitter_handle;
    data['facebook_handle'] = this.facebook_handle;
    data['instagram_handle'] = this.instagram_handle;
    return data;
  }

  @override
  Codable fromJson(Map<String, dynamic> json) {
    return PodcastExtra.fromJson(json);
  }
}
