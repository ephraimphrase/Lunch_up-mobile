// To parse this JSON data, do
//
//     final trayItem = trayItemFromJson(jsonString);

import 'dart:convert';

import 'package:lunch_up/models/meal_model.dart';

List<TrayItem> trayItemFromJson(String str) => List<TrayItem>.from(json.decode(str).map((x) => TrayItem.fromJson(x)));

String trayItemToJson(List<TrayItem> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TrayItem {
    int id;
    int quantity;
    Owner owner;
    Meal meal;

    TrayItem({
        required this.id,
        required this.quantity,
        required this.owner,
        required this.meal,
    });

    factory TrayItem.fromJson(Map<String, dynamic> json) => TrayItem(
        id: json["id"],
        quantity: json["quantity"],
        owner: Owner.fromJson(json["owner"]),
        meal: Meal.fromJson(json["meal"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "owner": owner.toJson(),
        "meal": meal.toJson(),
    };
}

class Owner {
    int id;
    String password;
    dynamic lastLogin;
    bool isSuperuser;
    String username;
    String firstName;
    String lastName;
    String email;
    bool isStaff;
    bool isActive;
    DateTime dateJoined;
    List<dynamic> groups;
    List<dynamic> userPermissions;

    Owner({
        required this.id,
        required this.password,
        required this.lastLogin,
        required this.isSuperuser,
        required this.username,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.isStaff,
        required this.isActive,
        required this.dateJoined,
        required this.groups,
        required this.userPermissions,
    });

    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        password: json["password"],
        lastLogin: json["last_login"],
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: DateTime.parse(json["date_joined"]),
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        userPermissions: List<dynamic>.from(json["user_permissions"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "last_login": lastLogin,
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined.toIso8601String(),
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "user_permissions": List<dynamic>.from(userPermissions.map((x) => x)),
    };
}
