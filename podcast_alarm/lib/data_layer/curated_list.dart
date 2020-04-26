import 'package:podcast_alarm/api/api_client.dart';

class CuratedList implements Codable {
  static const String cacheFilename = "curated_lists.json";

  String id;
  String title;
  List<dynamic> podcasts;
  String source_url;
  String description;
  int pub_date_ms;
  String source_domain;
  String listennotes_url;

  CuratedList({this.id, this.title, this.podcasts});

  CuratedList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    podcasts = json["podcasts"];
    source_url = json["source_url"];
    description = json["description"];
    pub_date_ms = json["pub_date_ms"];
    source_domain = json["source_domain"];
    listennotes_url = json["listennotes_url"];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["title"] = this.title;
    data["podcasts"] = this.podcasts;
    data["source_url"] = this.source_url;
    data["description"] = this.description;
    data["pub_date_ms"] = this.pub_date_ms;
    data["source_domain"] = this.source_domain;
    data["listennotes_url"] = this.listennotes_url;
    return data;
  }

  @override
  Codable fromJson(Map<String, dynamic> json) {
    return CuratedList.fromJson(json);
  }
}