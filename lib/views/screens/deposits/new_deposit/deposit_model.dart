// To parse this JSON data, do
//
//     final depositModelSearch = depositModelSearchFromJson(jsonString);

import 'dart:convert';

DepositModelSearch depositModelSearchFromJson(String str) => DepositModelSearch.fromJson(json.decode(str));

String depositModelSearchToJson(DepositModelSearch data) => json.encode(data.toJson());

class DepositModelSearch {
  bool? success;
  Data? data;

  DepositModelSearch({
    this.success,
    this.data,
  });

  factory DepositModelSearch.fromJson(Map<String, dynamic> json) => DepositModelSearch(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? name;
  String? currency;
  String? symbol;
  int? methodCode;
  String? gatewayAlias;
  dynamic minAmount;
  dynamic maxAmount;
  String? fixAmount;
  int? agentPoints;
  int? plainId;
  int? storePlain;
  int? storePlainId;
  int? becomeAgentGateway;
  int? duration;
  int? numberOfTimes;
  String? percentCharge;
  String? fixedCharge;
  String? rate;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? charge;
  String? payable;
  String? finalAmount;
  Method? method;

  Data({
    this.id,
    this.name,
    this.currency,
    this.symbol,
    this.methodCode,
    this.gatewayAlias,
    this.minAmount,
    this.maxAmount,
    this.fixAmount,
    this.agentPoints,
    this.plainId,
    this.storePlain,
    this.storePlainId,
    this.becomeAgentGateway,
    this.duration,
    this.numberOfTimes,
    this.percentCharge,
    this.fixedCharge,
    this.rate,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.charge,
    this.payable,
    this.finalAmount,
    this.method,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    currency: json["currency"],
    symbol: json["symbol"],
    methodCode: json["method_code"],
    gatewayAlias: json["gateway_alias"],
    minAmount: json["min_amount"],
    maxAmount: json["max_amount"],
    fixAmount: json["fix_amount"],
    agentPoints: json["agent_points"],
    plainId: json["plain_id"],
    storePlain: json["store_plain"],
    storePlainId: json["store_plain_id"],
    becomeAgentGateway: json["become_agent_gateway"],
    duration: json["duration"],
    numberOfTimes: json["number_of_times"],
    percentCharge: json["percent_charge"],
    fixedCharge: json["fixed_charge"],
    rate: json["rate"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    charge: json["charge"],
    payable: json["payable"],
    finalAmount: json["final_amount"],
    method: json["method"] == null ? null : Method.fromJson(json["method"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "currency": currency,
    "symbol": symbol,
    "method_code": methodCode,
    "gateway_alias": gatewayAlias,
    "min_amount": minAmount,
    "max_amount": maxAmount,
    "fix_amount": fixAmount,
    "agent_points": agentPoints,
    "plain_id": plainId,
    "store_plain": storePlain,
    "store_plain_id": storePlainId,
    "become_agent_gateway": becomeAgentGateway,
    "duration": duration,
    "number_of_times": numberOfTimes,
    "percent_charge": percentCharge,
    "fixed_charge": fixedCharge,
    "rate": rate,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "charge": charge,
    "payable": payable,
    "final_amount": finalAmount,
    "method": method?.toJson(),
  };
}

class Method {
  int? id;
  int? formId;
  String? code;
  String? name;
  String? alias;
  int? status;
  String? agentPoints;
  String? duration;
  String? numberOfTimes;
  List<dynamic>? supportedCurrencies;
  int? crypto;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Method({
    this.id,
    this.formId,
    this.code,
    this.name,
    this.alias,
    this.status,
    this.agentPoints,
    this.duration,
    this.numberOfTimes,
    this.supportedCurrencies,
    this.crypto,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Method.fromJson(Map<String, dynamic> json) => Method(
    id: json["id"],
    formId: json["form_id"],
    code: json["code"],
    name: json["name"],
    alias: json["alias"],
    status: json["status"],
    agentPoints: json["agent_points"],
    duration: json["duration"],
    numberOfTimes: json["number_of_times"],
    supportedCurrencies: json["supported_currencies"] == null ? [] : List<dynamic>.from(json["supported_currencies"]!.map((x) => x)),
    crypto: json["crypto"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "form_id": formId,
    "code": code,
    "name": name,
    "alias": alias,
    "status": status,
    "agent_points": agentPoints,
    "duration": duration,
    "number_of_times": numberOfTimes,
    "supported_currencies": supportedCurrencies == null ? [] : List<dynamic>.from(supportedCurrencies!.map((x) => x)),
    "crypto": crypto,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
