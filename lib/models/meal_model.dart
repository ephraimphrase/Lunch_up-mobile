// To parse this JSON data, do
//
//     final meal = mealFromJson(jsonString);

import 'dart:convert';

List<Meal> mealFromJson(String str) => List<Meal>.from(json.decode(str).map((x) => Meal.fromJson(x)));

String mealToJson(List<Meal> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Meal {
    int id;
    String name;
    String amount;
    String coverArt;
    int station;

    Meal({
        required this.id,
        required this.name,
        required this.amount,
        required this.coverArt,
        required this.station,
    });

    factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        coverArt: json["cover_art"],
        station: json["station"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "cover_art": coverArt,
        "station": station,
    };
}
