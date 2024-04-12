// To parse this JSON data, do
//
//     final searchApiModel = searchApiModelFromJson(jsonString);

import 'dart:convert';

SearchApiModel searchApiModelFromJson(String str) => SearchApiModel.fromJson(json.decode(str));

String searchApiModelToJson(SearchApiModel data) => json.encode(data.toJson());

class SearchApiModel {
  String? status;
  DataSearch? data;

  SearchApiModel({
    this.status,
    this.data,
  });

  factory SearchApiModel.fromJson(Map<String, dynamic> json) => SearchApiModel(
    status: json["status"],
    data: json["data"] == null ? null : DataSearch.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class DataSearch {
  List<User>? users;

  DataSearch({
    this.users,
  });

  factory DataSearch.fromJson(Map<String, dynamic> json) => DataSearch(
    users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
  };
}

class User {
  int? id;
  int? branchId;
  int? branchStaffId;
  String? accountType;
  String? userType;
  String? storeType;
  String? storePlanPurchase;
  dynamic companyName;
  dynamic vatNumber;
  dynamic userPec;
  dynamic electronicInvCode;
  String? accountNumber;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? countryCode;
  String? mobile;
  int? refBy;
  int? planSubscription;
  String? planName;
  String? userLevel;
  int? agentPoints;
  String? previousLevel;
  DateTime? levelUpdateDate;
  int? basicAgents;
  int? keyAgents;
  int? seniorAgents;
  int? topAgents;
  int? totalC300;
  int? agentKeyBranches;
  int? agentSeniorBranches;
  int? agentTopBranches;
  int? cKey;
  String? balance;
  String? wallet;
  String? pendingBounce;
  String? bounce;
  String? pendingKycardCommission;
  String? kycardCommission;
  int? referralCommissionCount;
  String? image;
  Address? address;
  int? status;
  int? ev;
  int? sv;
  dynamic verCodeSendAt;
  String? taxCode;
  int? ts;
  int? tv;
  dynamic tsc;
  int? kv;
  int? fv;
  int? stv;
  int? upd;
  dynamic kycData;
  int? profileComplete;
  dynamic banReason;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? dailyTransferLimit;
  String? monthlyTransferLimit;
  String? minimumTransferLimit;
  String? minimumBalanceLimit;
  String? maximumBalanceLimit;
  dynamic paypalAccountEmail;

  User({
    this.id,
    this.branchId,
    this.branchStaffId,
    this.accountType,
    this.userType,
    this.storeType,
    this.storePlanPurchase,
    this.companyName,
    this.vatNumber,
    this.userPec,
    this.electronicInvCode,
    this.accountNumber,
    this.firstname,
    this.lastname,
    this.username,
    this.email,
    this.countryCode,
    this.mobile,
    this.refBy,
    this.planSubscription,
    this.planName,
    this.userLevel,
    this.agentPoints,
    this.previousLevel,
    this.levelUpdateDate,
    this.basicAgents,
    this.keyAgents,
    this.seniorAgents,
    this.topAgents,
    this.totalC300,
    this.agentKeyBranches,
    this.agentSeniorBranches,
    this.agentTopBranches,
    this.cKey,
    this.balance,
    this.wallet,
    this.pendingBounce,
    this.bounce,
    this.pendingKycardCommission,
    this.kycardCommission,
    this.referralCommissionCount,
    this.image,
    this.address,
    this.status,
    this.ev,
    this.sv,
    this.verCodeSendAt,
    this.taxCode,
    this.ts,
    this.tv,
    this.tsc,
    this.kv,
    this.fv,
    this.stv,
    this.upd,
    this.kycData,
    this.profileComplete,
    this.banReason,
    this.createdAt,
    this.updatedAt,
    this.dailyTransferLimit,
    this.monthlyTransferLimit,
    this.minimumTransferLimit,
    this.minimumBalanceLimit,
    this.maximumBalanceLimit,
    this.paypalAccountEmail,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    branchId: json["branch_id"],
    branchStaffId: json["branch_staff_id"],
    accountType: json["account_type"],
    userType: json["user_type"],
    storeType: json["store_type"],
    storePlanPurchase: json["store_plan_purchase"],
    companyName: json["company_name"],
    vatNumber: json["vat_number"],
    userPec: json["user_pec"],
    electronicInvCode: json["electronic_inv_code"],
    accountNumber: json["account_number"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    username: json["username"],
    email: json["email"],
    countryCode: json["country_code"],
    mobile: json["mobile"],
    refBy: json["ref_by"],
    planSubscription: json["plan_subscription"],
    planName: json["plan_name"],
    userLevel: json["user_level"],
    agentPoints: json["agent_points"],
    previousLevel: json["previous_level"],
    levelUpdateDate: json["level_update_date"] == null ? null : DateTime.parse(json["level_update_date"]),
    basicAgents: json["basic_agents"],
    keyAgents: json["key_agents"],
    seniorAgents: json["senior_agents"],
    topAgents: json["top_agents"],
    totalC300: json["totalC300"],
    agentKeyBranches: json["agent_key_branches"],
    agentSeniorBranches: json["agent_senior_branches"],
    agentTopBranches: json["agent_top_branches"],
    cKey: json["c_key"],
    balance: json["balance"],
    wallet: json["wallet"],
    pendingBounce: json["pending_bounce"],
    bounce: json["bounce"],
    pendingKycardCommission: json["pending_kycard_commission"],
    kycardCommission: json["kycard_commission"],
    referralCommissionCount: json["referral_commission_count"],
    image: json["image"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    status: json["status"],
    ev: json["ev"],
    sv: json["sv"],
    verCodeSendAt: json["ver_code_send_at"],
    taxCode: json["tax_code"],
    ts: json["ts"],
    tv: json["tv"],
    tsc: json["tsc"],
    kv: json["kv"],
    fv: json["fv"],
    stv: json["stv"],
    upd: json["upd"],
    kycData: json["kyc_data"],
    profileComplete: json["profile_complete"],
    banReason: json["ban_reason"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    dailyTransferLimit: json["daily_transfer_limit"],
    monthlyTransferLimit: json["monthly_transfer_limit"],
    minimumTransferLimit: json["minimum_transfer_limit"],
    minimumBalanceLimit: json["minimum_balance_limit"],
    maximumBalanceLimit: json["maximum_balance_limit"],
    paypalAccountEmail: json["paypal_account_email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch_id": branchId,
    "branch_staff_id": branchStaffId,
    "account_type": accountType,
    "user_type": userType,
    "store_type": storeType,
    "store_plan_purchase": storePlanPurchase,
    "company_name": companyName,
    "vat_number": vatNumber,
    "user_pec": userPec,
    "electronic_inv_code": electronicInvCode,
    "account_number": accountNumber,
    "firstname": firstname,
    "lastname": lastname,
    "username": username,
    "email": email,
    "country_code": countryCode,
    "mobile": mobile,
    "ref_by": refBy,
    "plan_subscription": planSubscription,
    "plan_name": planName,
    "user_level": userLevel,
    "agent_points": agentPoints,
    "previous_level": previousLevel,
    "level_update_date": levelUpdateDate?.toIso8601String(),
    "basic_agents": basicAgents,
    "key_agents": keyAgents,
    "senior_agents": seniorAgents,
    "top_agents": topAgents,
    "totalC300": totalC300,
    "agent_key_branches": agentKeyBranches,
    "agent_senior_branches": agentSeniorBranches,
    "agent_top_branches": agentTopBranches,
    "c_key": cKey,
    "balance": balance,
    "wallet": wallet,
    "pending_bounce": pendingBounce,
    "bounce": bounce,
    "pending_kycard_commission": pendingKycardCommission,
    "kycard_commission": kycardCommission,
    "referral_commission_count": referralCommissionCount,
    "image": image,
    "address": address?.toJson(),
    "status": status,
    "ev": ev,
    "sv": sv,
    "ver_code_send_at": verCodeSendAt,
    "tax_code": taxCode,
    "ts": ts,
    "tv": tv,
    "tsc": tsc,
    "kv": kv,
    "fv": fv,
    "stv": stv,
    "upd": upd,
    "kyc_data": kycData,
    "profile_complete": profileComplete,
    "ban_reason": banReason,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "daily_transfer_limit": dailyTransferLimit,
    "monthly_transfer_limit": monthlyTransferLimit,
    "minimum_transfer_limit": minimumTransferLimit,
    "minimum_balance_limit": minimumBalanceLimit,
    "maximum_balance_limit": maximumBalanceLimit,
    "paypal_account_email": paypalAccountEmail,
  };
}

class Address {
  String? country;
  String? address;
  String? state;
  String? zip;
  String? city;

  Address({
    this.country,
    this.address,
    this.state,
    this.zip,
    this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    country: json["country"],
    address: json["address"],
    state: json["state"],
    zip: json["zip"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "address": address,
    "state": state,
    "zip": zip,
    "city": city,
  };
}
