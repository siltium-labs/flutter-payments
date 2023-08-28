extension IsNotNullOrEmpty on String? {
  bool isNotNullOrEmpty() {
    return this != null && this!.isNotEmpty;
  }

  bool get isNullOrEmpty => this == null || (this?.isEmpty ?? false);

  bool get isNotNullAndNotEmpty => this != null && (this?.isNotEmpty ?? false);
}
