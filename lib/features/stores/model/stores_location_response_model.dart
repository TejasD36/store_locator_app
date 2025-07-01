import 'dart:convert';

class StoresLocationResponseModel {
  String? msg;
  List<StoresData>? data;

  StoresLocationResponseModel({this.msg, this.data});

  factory StoresLocationResponseModel.fromRawJson(String str) => StoresLocationResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoresLocationResponseModel.fromJson(Map<String, dynamic> json) => StoresLocationResponseModel(
    msg: json["msg"],
    data: json["data"] == null ? [] : List<StoresData>.from(json["data"]!.map((x) => StoresData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {"msg": msg, "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson()))};
}

class StoresData {
  String? code;
  String? storeLocation;
  String? latitude;
  String? longitude;
  String? storeAddress;
  Timezone? timezone;
  double? distance;
  int? isNearestStore;
  DayOfWeek? dayOfWeek;
  StartTime? startTime;
  EndTime? endTime;
  String? startTimeLabel;
  String? endTimeLabel;
  String? dayOfWeekLabel;

  StoresData({
    this.code,
    this.storeLocation,
    this.latitude,
    this.longitude,
    this.storeAddress,
    this.timezone,
    this.distance,
    this.isNearestStore,
    this.dayOfWeek,
    this.startTime,
    this.endTime,
    this.startTimeLabel,
    this.endTimeLabel,
    this.dayOfWeekLabel,
  });

  factory StoresData.fromRawJson(String str) => StoresData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoresData.fromJson(Map<String, dynamic> json) => StoresData(
    code: json["code"],
    storeLocation: json["storeLocation"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    storeAddress: json["storeAddress"],
    timezone: timezoneValues.map[json["timezone"]]!,
    distance: json["distance"]?.toDouble(),
    isNearestStore: json["isNearestStore"],
    dayOfWeek: dayOfWeekValues.map[json["dayOfWeek"]]!,
    startTime: startTimeValues.map[json["start_time"]]!,
    endTime: endTimeValues.map[json["end_time"]]!,
    dayOfWeekLabel: json["dayOfWeek"],
    startTimeLabel: json["start_time"],
    endTimeLabel: json["end_time"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "storeLocation": storeLocation,
    "latitude": latitude,
    "longitude": longitude,
    "storeAddress": storeAddress,
    "timezone": timezoneValues.reverse[timezone],
    "distance": distance,
    "isNearestStore": isNearestStore,
    "dayOfWeek": dayOfWeekValues.reverse[dayOfWeek],
    "start_time": startTimeValues.reverse[startTime],
    "end_time": endTimeValues.reverse[endTime],
  };
}

enum DayOfWeek { THURSDAY }

final dayOfWeekValues = EnumValues({"Thursday": DayOfWeek.THURSDAY});

enum EndTime { THE_0600_PM }

final endTimeValues = EnumValues({"06:00 PM": EndTime.THE_0600_PM});

enum StartTime { THE_1000_AM }

final startTimeValues = EnumValues({"10:00 AM": StartTime.THE_1000_AM});

enum Timezone { ASIA_KOLKATA }

final timezoneValues = EnumValues({"Asia/Kolkata": Timezone.ASIA_KOLKATA});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
