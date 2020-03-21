import 'package:podcast_alarm/api/api_client.dart';

class Genre implements Codable {
  static const String cacheFilename = "genres.json";
  int id;
  String name;
  int parent_id;

  Genre({this.id, this.name, this.parent_id});

  Genre.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    parent_id = json["parent_id"];
    name = json["name"];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parent_id;
    return data;
  }

  @override
  Codable fromJson(Map<String, dynamic> json) {
    return Genre.fromJson(json);
  }
}