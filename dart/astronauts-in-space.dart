// To parse this JSON data, do
//
//     final astronautsInSpace = astronautsInSpaceFromJson(jsonString);
//     final issCurrentLocation = issCurrentLocationFromJson(jsonString);

import 'dart:convert';

AstronautsInSpace astronautsInSpaceFromJson(String str) {
    final jsonData = json.decode(str);
    return AstronautsInSpace.fromJson(jsonData);
}

String astronautsInSpaceToJson(AstronautsInSpace data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

IssCurrentLocation issCurrentLocationFromJson(String str) {
    final jsonData = json.decode(str);
    return IssCurrentLocation.fromJson(jsonData);
}

String issCurrentLocationToJson(IssCurrentLocation data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class AstronautsInSpace {
    String message;
    List<Person> people;
    int number;

    AstronautsInSpace({
        this.message,
        this.people,
        this.number,
    });

    factory AstronautsInSpace.fromJson(Map<String, dynamic> json) => new AstronautsInSpace(
        message: json["message"],
        people: new List<Person>.from(json["people"].map((x) => Person.fromJson(x))),
        number: json["number"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "people": new List<dynamic>.from(people.map((x) => x.toJson())),
        "number": number,
    };
}

class Person {
    String craft;
    String name;

    Person({
        this.craft,
        this.name,
    });

    factory Person.fromJson(Map<String, dynamic> json) => new Person(
        craft: json["craft"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "craft": craft,
        "name": name,
    };
}

class IssCurrentLocation {
    IssPosition issPosition;
    int timestamp;
    String message;

    IssCurrentLocation({
        this.issPosition,
        this.timestamp,
        this.message,
    });

    factory IssCurrentLocation.fromJson(Map<String, dynamic> json) => new IssCurrentLocation(
        issPosition: IssPosition.fromJson(json["iss_position"]),
        timestamp: json["timestamp"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "iss_position": issPosition.toJson(),
        "timestamp": timestamp,
        "message": message,
    };
}

class IssPosition {
    String longitude;
    String latitude;

    IssPosition({
        this.longitude,
        this.latitude,
    });

    factory IssPosition.fromJson(Map<String, dynamic> json) => new IssPosition(
        longitude: json["longitude"],
        latitude: json["latitude"],
    );

    Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
    };
}
