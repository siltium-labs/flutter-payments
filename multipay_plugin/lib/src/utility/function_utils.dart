T? classFromJson<T>(
    Map<String, dynamic>? json, T Function(Map<String, dynamic>) fromJson) {
  return json != null ? fromJson(json) : null;
}

Map<String, dynamic>? classToJson(dynamic object) {
  return object != null ? object!.toJson() : null;
}
