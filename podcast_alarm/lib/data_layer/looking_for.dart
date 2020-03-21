import 'package:podcast_alarm/api/api_client.dart';

class LookingFor implements Codable {
  bool guests;
  bool cohosts;
  bool sponsors;
  bool cross_promotion;

  LookingFor.fromJson(Map<String, dynamic> json) {
    this.guests = json["guests"];
    this.cohosts = json["cohosts"];
    this.sponsors = json["sponsors"];
    this.cross_promotion = json["cross_promotion"];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["guests"] = this.guests;
    data["cohosts"] = this.cohosts;
    data["sponsors"] = this.sponsors;
    data["cross_promotion"] = this.cross_promotion;
    return data;
  }

  @override
  Codable fromJson(Map<String, dynamic> json) {
    return LookingFor.fromJson(json);
  }
}
