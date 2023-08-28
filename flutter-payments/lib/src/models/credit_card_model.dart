class CreditCardModel {
  CreditCardModel(
    this.cardNumber,
    this.expiryDate,
    this.cardHolderName,
    this.cvvCode,
    this.isCvvFocused,
    this.documentType,
    this.documentNumber,
  );

  /// Number of the credit/debit card.
  String cardNumber = '';

  /// Expiry date of the card.
  String expiryDate = '';

  /// Name of the card holder.
  String cardHolderName = '';

  /// Cvv code on card.
  String cvvCode = '';

  /// document type.
  String documentType = '';

  /// Cvv code on card.
  String documentNumber = '';

  /// A boolean for indicating if cvv is focused or not.
  bool isCvvFocused = false;
}
