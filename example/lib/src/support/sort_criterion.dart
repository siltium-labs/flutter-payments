class SortCriterion {
  String? property;
  bool? descending;

  SortCriterion({this.descending, this.property});

  Map<String, dynamic> toJson() => {
        "property": property,
        "descending": descending,
      };
}
