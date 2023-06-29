import 'macro_access_token.dart';

class MacroClientCredentialsModel {
  String? guid;
  String? phrase;
  MacroAccessTokenModel? token;

  MacroClientCredentialsModel({
    this.guid,
    this.phrase,
    this.token,
  });

  factory MacroClientCredentialsModel.fromJson(Map<String, dynamic> json) {
    return MacroClientCredentialsModel(
      guid: json["guid"],
      phrase: json["frase"],
    );
  }

  Map<String, dynamic> toJson() => {
        "guid": guid,
        "frase": phrase,
      };
}
