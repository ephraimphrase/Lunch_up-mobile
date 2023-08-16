// To parse this JSON data, do
//
//     final station = stationFromJson(jsonString);

import 'dart:convert';

List<Station> stationFromJson(String str) => List<Station>.from(json.decode(str).map((x) => Station.fromJson(x)));

String stationToJson(List<Station> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Station {
  int id;
  String name;
  String location;
  String coverArt;
  String delivery;
  String opening;
  String closing;

  Station({
      required this.id,
      required this.name,
      required this.location,
      required this.coverArt,
      required this.delivery,
      required this.opening,
      required this.closing,
  });

  factory Station.fromJson(Map<String, dynamic> json) => Station(
      id: json["id"],
      name: json["name"],
      location: json["location"],
      coverArt: json["cover_art"],
      delivery: json["delivery"],
      opening: json["opening"],
      closing: json["closing"],
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "location": location,
      "cover_art": coverArt,
      "delivery": delivery,
      "opening": opening,
      "closing": closing,
  };
}