// To parse this JSON data, do
//
//     final welcomeSuccess = welcomeSuccessFromJson(jsonString);

import 'dart:convert';

WelcomeSuccess welcomeSuccessFromJson(String str) =>
    WelcomeSuccess.fromJson(json.decode(str));

String welcomeSuccessToJson(WelcomeSuccess data) => json.encode(data.toJson());

class WelcomeSuccess {
  Meta meta;
  List<Autocomplete> autocomplete;

  WelcomeSuccess({
    required this.meta,
    required this.autocomplete,
  });

  factory WelcomeSuccess.fromJson(Map<String, dynamic> json) => WelcomeSuccess(
        meta: Meta.fromJson(json["meta"]),
        autocomplete: List<Autocomplete>.from(
            json["autocomplete"].map((x) => Autocomplete.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "autocomplete": List<dynamic>.from(autocomplete.map((x) => x.toJson())),
      };
}

class Autocomplete {
  String areaType;
  String id;
  double score;
  String? state;
  String stateCode;
  String country;
  Centroid centroid;
  String slugId;
  String geoId;
  String? city;
  bool? countyNeededForUniq;
  List<County>? counties;

  Autocomplete({
    required this.areaType,
    required this.id,
    required this.score,
    this.state,
    required this.stateCode,
    required this.country,
    required this.centroid,
    required this.slugId,
    required this.geoId,
    this.city,
    this.countyNeededForUniq,
    this.counties,
  });

  factory Autocomplete.fromJson(Map<String, dynamic> json) => Autocomplete(
        areaType: json["area_type"]!,
        id: json["_id"],
        score: json["_score"]?.toDouble(),
        state: json["state"],
        stateCode: json["state_code"],
        country: json["country"]!,
        centroid: Centroid.fromJson(json["centroid"]),
        slugId: json["slug_id"],
        geoId: json["geo_id"],
        city: json["city"],
        countyNeededForUniq: json["county_needed_for_uniq"],
        counties: json["counties"] == null
            ? []
            : List<County>.from(
                json["counties"]!.map((x) => County.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "area_type": areaType,
        "_id": id,
        "_score": score,
        "state": state,
        "state_code": stateCode,
        "country": country,
        "centroid": centroid.toJson(),
        "slug_id": slugId,
        "geo_id": geoId,
        "city": city,
        "county_needed_for_uniq": countyNeededForUniq,
        "counties": counties == null
            ? []
            : List<dynamic>.from(counties!.map((x) => x.toJson())),
      };
}

class Centroid {
  double lon;
  double lat;

  Centroid({
    required this.lon,
    required this.lat,
  });

  factory Centroid.fromJson(Map<String, dynamic> json) => Centroid(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
      };
}

class County {
  String name;
  String fips;
  String stateCode;

  County({
    required this.name,
    required this.fips,
    required this.stateCode,
  });

  factory County.fromJson(Map<String, dynamic> json) => County(
        name: json["name"],
        fips: json["fips"],
        stateCode: json["state_code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "fips": fips,
        "state_code": stateCode,
      };
}

class Meta {
  String version;
  int esTook;
  int esTotalHits;

  Meta({
    required this.version,
    required this.esTook,
    required this.esTotalHits,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        version: json["version"],
        esTook: json["es_took"],
        esTotalHits: json["es_total_hits"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
        "es_took": esTook,
        "es_total_hits": esTotalHits,
      };
}
