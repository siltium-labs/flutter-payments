extension IsNotNullOrEmpty on String? {
  bool isNotNullOrNotEmpty() {
    return this != null && this!.isNotEmpty;
  }

  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? false);

  bool get isNotNullAndNotEmpty => this != null && (this?.isNotEmpty ?? false);
}

extension HasValue on String? {
  bool hasValue() {
    return (this != null && this!.isNotEmpty);
  }
}
