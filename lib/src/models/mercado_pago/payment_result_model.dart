class PaymentResultModel {
  late String result;
  int? id;
  String? status;
  String? statusDetail;
  String? paymentMethodId;
  String? paymentTypeId;
  String? issuerId;
  int? installments;
  bool? captured;
  bool? liveMode;
  String? operationType;
  String? transactionAmount;
  String? errorMessage;
  // TODO: Payer
  // TODO: transactionDetails

  PaymentResultModel({
    required this.result,
    this.id,
    this.status,
    this.statusDetail,
    this.paymentMethodId,
    this.paymentTypeId,
    this.issuerId,
    this.installments,
    this.captured,
    this.liveMode,
    this.operationType,
    this.transactionAmount,
    this.errorMessage,
  });

  PaymentResultModel.fromJson(Map<String, dynamic> json) {
    result = json['result'] as String;
    id = json['id'] as int?;
    status = json['status'] as String?;
    statusDetail = json['statusDetail'] as String?;
    paymentMethodId = json['paymentMethodId'] as String?;
    paymentTypeId = json['paymentTypeId'] as String?;
    issuerId = json['issuerId'] as String?;
    installments = json['installments'] as int?;
    captured = json['captured'] as bool?;
    liveMode = json['liveMode'] as bool?;
    operationType = json['operationType'] as String?;
    transactionAmount = json['transactionAmount'] as String?;
    errorMessage = json['errorMessage'] as String?;
  }
}
