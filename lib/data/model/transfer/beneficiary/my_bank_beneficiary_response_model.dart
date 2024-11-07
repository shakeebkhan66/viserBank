import 'package:viser_bank/data/model/general_setting/general_settings_response_model.dart';
import '../../auth/registration_response_model.dart';

// class MyBankBeneficiaryResponseModel {
//   MyBankBeneficiaryResponseModel({
//       String? remark,
//       String? status,
//       Message? message,
//       MainData? data,}){
//     _remark = remark;
//     _status = status;
//     _message = message;
//     _data = data;
// }
//
//   MyBankBeneficiaryResponseModel.fromJson(dynamic json) {
//     _remark = json['remark'];
//     _status = json['status'];
//     _message = json['message'] != null ? Message.fromJson(json['message']) : null;
//     _data = json['data'] != null ? MainData.fromJson(json['data']) : null;
//   }
//   String? _remark;
//   String? _status;
//   Message? _message;
//   MainData? _data;
//
//   String? get remark => _remark;
//   String? get status => _status;
//   Message? get message => _message;
//   MainData? get data => _data;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['remark'] = _remark;
//     map['status'] = _status;
//     if (_message != null) {
//       map['message'] = _message?.toJson();
//     }
//     if (_data != null) {
//       map['data'] = _data?.toJson();
//     }
//     return map;
//   }
//
// }
//
// class MainData {
//   MainData({
//     Beneficiaries? beneficiaries,
//     String? transferCharge,
//     GeneralSetting? general,}){
//     _beneficiaries = beneficiaries;
//     _transferCharge = transferCharge;
//     _general = general;
// }
//
//   MainData.fromJson(dynamic json) {
//     _beneficiaries = json['beneficiaries'] != null ? Beneficiaries.fromJson(json['beneficiaries']) : null;
//     _transferCharge = json['transfer_charge']!=null?json['transfer_charge'].toString():'';
//     _general = json['general'] != null ? GeneralSetting.fromJson(json['general']) : null;
//   }
//
//   Beneficiaries? _beneficiaries;
//   String? _transferCharge;
//   GeneralSetting? _general;
//
//   Beneficiaries? get beneficiaries => _beneficiaries;
//   String? get transferCharge => _transferCharge;
//   GeneralSetting? get general => _general;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_beneficiaries != null) {
//       map['beneficiaries'] = _beneficiaries?.toJson();
//     }
//     map['transfer_charge'] = _transferCharge;
//     if (_general != null) {
//       map['general'] = _general?.toJson();
//     }
//     return map;
//   }
//
// }
//
// class Beneficiaries {
//   Beneficiaries({
//       List<Data>? data,
//       dynamic nextPageUrl,
//       String? path}){
//     _data = data;
//     _nextPageUrl = nextPageUrl;
//     _path = path;
// }
//
//   Beneficiaries.fromJson(dynamic json) {
//     if (json['data'] != null) {
//       _data = [];
//       json['data'].forEach((v) {
//         _data?.add(Data.fromJson(v));
//       });
//     }
//     _nextPageUrl = json['next_page_url'];
//     _path = json['path'];
//   }
//
//   List<Data>? _data;
//   dynamic _nextPageUrl;
//   String? _path;
//
//   List<Data>? get data => _data;
//   dynamic get nextPageUrl => _nextPageUrl;
//   String? get path => _path;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (_data != null) {
//       map['data'] = _data?.map((v) => v.toJson()).toList();
//     }
//     map['next_page_url'] = _nextPageUrl;
//     map['path'] = _path;
//     return map;
//   }
//
// }
//
//
// class Data {
//   Data({
//       int? id,
//       String? userId,
//       String? beneficiaryType,
//       String? beneficiaryId,
//       String? accountNumber,
//       String? accountType,
//       String? accountName,
//       String? shortName,
//       dynamic details,
//       String? createdAt,
//       String? updatedAt}){
//     _id = id;
//     _userId = userId;
//     _beneficiaryType = beneficiaryType;
//     _beneficiaryId = beneficiaryId;
//     _accountNumber = accountNumber;
//     _accountType = accountType;
//     _accountName = accountName;
//     _shortName = shortName;
//     _details = details;
//     _createdAt = createdAt;
//     _updatedAt = updatedAt;
// }
//
//   Data.fromJson(dynamic json) {
//     _id = json['id'];
//     _userId = json['user_id'].toString();
//     _beneficiaryType = json['beneficiary_type'].toString();
//     _beneficiaryId = json['beneficiary_id'].toString();
//     _accountNumber = json['account_number']!=null?json['account_number'].toString():'';
//     _accountType = json['account_type']!=null?json['account_type'].toString():'';
//     _accountName = json['account_name']!=null?json['account_name'].toString():'';
//     _shortName = json['short_name']!=null?json['short_name'].toString():'';
//     _details = json['details']!=null?json['details'].toString():'';
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//   }
//
//   int? _id;
//   String? _userId;
//   String? _beneficiaryType;
//   String? _beneficiaryId;
//   String? _accountNumber;
//   String? _accountType;
//   String? _accountName;
//   String? _shortName;
//   dynamic _details;
//   String? _createdAt;
//   String? _updatedAt;
//
//   int? get id => _id;
//   String? get userId => _userId;
//   String? get beneficiaryType => _beneficiaryType;
//   String? get beneficiaryId => _beneficiaryId;
//   String? get accountNumber => _accountNumber;
//   String? get accountType => _accountType;
//   String? get accountName => _accountName;
//   String? get shortName => _shortName;
//   dynamic get details => _details;
//   String? get createdAt => _createdAt;
//   String? get updatedAt => _updatedAt;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = _id;
//     map['user_id'] = _userId;
//     map['beneficiary_type'] = _beneficiaryType;
//     map['beneficiary_id'] = _beneficiaryId;
//     map['account_number'] = _accountNumber;
//     map['account_type'] = _accountNumber;
//     map['account_name'] = _accountName;
//     map['short_name'] = _shortName;
//     map['details'] = _details;
//     map['created_at'] = _createdAt;
//     map['updated_at'] = _updatedAt;
//     return map;
//   }
//
// }



class MyBankBeneficiaryResponseModel {
  String? remark;
  String? status;
  MyBankBeneficiaryMessage? message;
  MyBankBeneficiaryData? data;

  MyBankBeneficiaryResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory MyBankBeneficiaryResponseModel.fromJson(Map<String, dynamic> json) =>
      MyBankBeneficiaryResponseModel(
        remark: json['remark'],
        status: json['status'],
        message: MyBankBeneficiaryMessage.fromJson(json['message']),
        data: MyBankBeneficiaryData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
    'remark': remark,
    'status': status,
    'message': message?.toJson(),
    'data': data?.toJson(),
  };
}

class MyBankBeneficiaryMessage {
  List<String>? success;

  MyBankBeneficiaryMessage({this.success});

  factory MyBankBeneficiaryMessage.fromJson(Map<String, dynamic> json) =>
      MyBankBeneficiaryMessage(
        success: List<String>.from(json['success']),
      );

  get error => null;

  Map<String, dynamic> toJson() => {
    'success': List<dynamic>.from(success!.map((x) => x)),
  };
}

class MyBankBeneficiaryData {
  MyBankBeneficiary? beneficiaries;
  String? transferCharge;
  MyBankBeneficiaryGeneral? general;

  MyBankBeneficiaryData({
    this.beneficiaries,
    this.transferCharge,
    this.general,
  });

  factory MyBankBeneficiaryData.fromJson(Map<String, dynamic> json) =>
      MyBankBeneficiaryData(
        beneficiaries: MyBankBeneficiary.fromJson(json['beneficiaries']),
        transferCharge: json['transfer_charge'],
        general: MyBankBeneficiaryGeneral.fromJson(json['general']),
      );

  Map<String, dynamic> toJson() => {
    'beneficiaries': beneficiaries?.toJson(),
    'transfer_charge': transferCharge,
    'general': general?.toJson(),
  };
}

class MyBankBeneficiary {
  int? currentPage;
  List<MyBankBeneficiaryDatum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  MyBankBeneficiary({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory MyBankBeneficiary.fromJson(Map<String, dynamic> json) =>
      MyBankBeneficiary(
        currentPage: json['current_page'],
        data: List<MyBankBeneficiaryDatum>.from(
            json['data'].map((x) => MyBankBeneficiaryDatum.fromJson(x))),
        firstPageUrl: json['first_page_url'],
        from: json['from'],
        lastPage: json['last_page'],
        lastPageUrl: json['last_page_url'],
        nextPageUrl: json['next_page_url'],
        path: json['path'],
        perPage: json['per_page'],
        prevPageUrl: json['prev_page_url'],
        to: json['to'],
        total: json['total'],
      );

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'data': List<dynamic>.from(data!.map((x) => x.toJson())),
    'first_page_url': firstPageUrl,
    'from': from,
    'last_page': lastPage,
    'last_page_url': lastPageUrl,
    'next_page_url': nextPageUrl,
    'path': path,
    'per_page': perPage,
    'prev_page_url': prevPageUrl,
    'to': to,
    'total': total,
  };
}

class MyBankBeneficiaryDatum {
  int? id;
  int? userId;
  String? beneficiaryType;
  int? beneficiaryId;
  String? accountNumber;
  String? accountName;
  String? shortName;
  dynamic details;
  String? createdAt;
  String? updatedAt;
  MyBankBeneficiarySentTo? sentTo;

  MyBankBeneficiaryDatum({
    this.id,
    this.userId,
    this.beneficiaryType,
    this.beneficiaryId,
    this.accountNumber,
    this.accountName,
    this.shortName,
    this.details,
    this.createdAt,
    this.updatedAt,
    this.sentTo,
  });

  factory MyBankBeneficiaryDatum.fromJson(Map<String, dynamic> json) =>
      MyBankBeneficiaryDatum(
        id: json['id'],
        userId: json['user_id'],
        beneficiaryType: json['beneficiary_type'],
        beneficiaryId: json['beneficiary_id'],
        accountNumber: json['account_number'],
        accountName: json['account_name'],
        shortName: json['short_name'],
        details: json['details'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        sentTo: MyBankBeneficiarySentTo.fromJson(json['sentTo']),
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'beneficiary_type': beneficiaryType,
    'beneficiary_id': beneficiaryId,
    'account_number': accountNumber,
    'account_name': accountName,
    'short_name': shortName,
    'details': details,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'sentTo': sentTo?.toJson(),
  };
}

class MyBankBeneficiarySentTo {
  int? id;
  int? branchId;
  int? branchStaffId;
  String? accountType;
  String? userType;
  String? storeType;
  String? storePlanPurchase;
  String? companyName;
  String? vatNumber;
  String? userPec;
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
  String? levelUpdateDate;
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
  dynamic image;
  MyBankBeneficiaryAddress? address;
  int? status;
  int? ev;
  int? sv;
  dynamic verCodeSendAt;
  dynamic taxCode;
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
  String? createdAt;
  String? updatedAt;
  String? dailyTransferLimit;
  String? monthlyTransferLimit;
  String? minimumTransferLimit;
  String? minimumBalanceLimit;
  String? maximumBalanceLimit;
  dynamic paypalAccountEmail;
  dynamic currentMonthPersonalTurnover;
  int? accept;
  dynamic signDocument;

  MyBankBeneficiarySentTo({
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
    this.currentMonthPersonalTurnover,
    this.accept,
    this.signDocument,
  });

  factory MyBankBeneficiarySentTo.fromJson(Map<String, dynamic> json) =>
      MyBankBeneficiarySentTo(
        id: json['id'],
        branchId: json['branch_id'],
        branchStaffId: json['branch_staff_id'],
        accountType: json['account_type'],
        userType: json['user_type'],
        storeType: json['store_type'],
        storePlanPurchase: json['store_plan_purchase'],
        companyName: json['company_name'],
        vatNumber: json['vat_number'],
        userPec: json['user_pec'],
        electronicInvCode: json['electronic_inv_code'],
        accountNumber: json['account_number'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        username: json['username'],
        email: json['email'],
        countryCode: json['country_code'],
        mobile: json['mobile'],
        refBy: json['ref_by'],
        planSubscription: json['plan_subscription'],
        planName: json['plan_name'],
        userLevel: json['user_level'],
        agentPoints: json['agent_points'],
        previousLevel: json['previous_level'],
        levelUpdateDate: json['level_update_date'],
        basicAgents: json['basic_agents'],
        keyAgents: json['key_agents'],
        seniorAgents: json['senior_agents'],
        topAgents: json['top_agents'],
        totalC300: json['totalC300'],
        agentKeyBranches: json['agent_key_branches'],
        agentSeniorBranches: json['agent_senior_branches'],
        agentTopBranches: json['agent_top_branches'],
        cKey: json['c_key'],
        balance: json['balance'],
        wallet: json['wallet'],
        pendingBounce: json['pending_bounce'],
        bounce: json['bounce'],
        pendingKycardCommission: json['pending_kycard_commission'],
        kycardCommission: json['kycard_commission'],
        referralCommissionCount: json['referral_commission_count'],
        image: json['image'],
        address: MyBankBeneficiaryAddress.fromJson(json['address']),
        status: json['status'],
        ev: json['ev'],
        sv: json['sv'],
        verCodeSendAt: json['ver_code_send_at'],
        taxCode: json['tax_code'],
        ts: json['ts'],
        tv: json['tv'],
        tsc: json['tsc'],
        kv: json['kv'],
        fv: json['fv'],
        stv: json['stv'],
        upd: json['upd'],
        kycData: json['kyc_data'],
        profileComplete: json['profile_complete'],
        banReason: json['ban_reason'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        dailyTransferLimit: json['daily_transfer_limit'],
        monthlyTransferLimit: json['monthly_transfer_limit'],
        minimumTransferLimit: json['minimum_transfer_limit'],
        minimumBalanceLimit: json['minimum_balance_limit'],
        maximumBalanceLimit: json['maximum_balance_limit'],
        paypalAccountEmail: json['paypal_account_email'],
        currentMonthPersonalTurnover: json['current_month_personal_turnover'],
        accept: json['accept'],
        signDocument: json['sign_document'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'branch_id': branchId,
    'branch_staff_id': branchStaffId,
    'account_type': accountType,
    'user_type': userType,
    'store_type': storeType,
    'store_plan_purchase': storePlanPurchase,
    'company_name': companyName,
    'vat_number': vatNumber,
    'user_pec': userPec,
    'electronic_inv_code': electronicInvCode,
    'account_number': accountNumber,
    'firstname': firstname,
    'lastname': lastname,
    'username': username,
    'email': email,
    'country_code': countryCode,
    'mobile': mobile,
    'ref_by': refBy,
    'plan_subscription': planSubscription,
    'plan_name': planName,
    'user_level': userLevel,
    'agent_points': agentPoints,
    'previous_level': previousLevel,
    'level_update_date': levelUpdateDate,
    'basic_agents': basicAgents,
    'key_agents': keyAgents,
    'senior_agents': seniorAgents,
    'top_agents': topAgents,
    'totalC300': totalC300,
    'agent_key_branches': agentKeyBranches,
    'agent_senior_branches': agentSeniorBranches,
    'agent_top_branches': agentTopBranches,
    'c_key': cKey,
    'balance': balance,
    'wallet': wallet,
    'pending_bounce': pendingBounce,
    'bounce': bounce,
    'pending_kycard_commission': pendingKycardCommission,
    'kycard_commission': kycardCommission,
    'referral_commission_count': referralCommissionCount,
    'image': image,
    'address': address?.toJson(),
    'status': status,
    'ev': ev,
    'sv': sv,
    'ver_code_send_at': verCodeSendAt,
    'tax_code': taxCode,
    'ts': ts,
    'tv': tv,
    'tsc': tsc,
    'kv': kv,
    'fv': fv,
    'stv': stv,
    'upd': upd,
    'kyc_data': kycData,
    'profile_complete': profileComplete,
    'ban_reason': banReason,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'daily_transfer_limit': dailyTransferLimit,
    'monthly_transfer_limit': monthlyTransferLimit,
    'minimum_transfer_limit': minimumTransferLimit,
    'minimum_balance_limit': minimumBalanceLimit,
    'maximum_balance_limit': maximumBalanceLimit,
    'paypal_account_email': paypalAccountEmail,
    'current_month_personal_turnover': currentMonthPersonalTurnover,
    'accept': accept,
    'sign_document': signDocument,
  };
}

class MyBankBeneficiaryAddress {
  String? address;
  String? city;
  String? state;
  String? zip;
  String? country;

  MyBankBeneficiaryAddress({
    this.address,
    this.city,
    this.state,
    this.zip,
    this.country,
  });

  factory MyBankBeneficiaryAddress.fromJson(Map<String, dynamic> json) =>
      MyBankBeneficiaryAddress(
        address: json['address'],
        city: json['city'],
        state: json['state'],
        zip: json['zip'],
        country: json['country'],
      );

  Map<String?, dynamic> toJson() => {
    'address': address,
    'city': city,
    'state': state,
    'zip': zip,
    'country': country,
  };
}

class MyBankBeneficiaryGeneral {
  int? id;
  String? siteName;
  String? curText;
  String? curSym;
  String? emailFrom;
  String? smsBody;
  String? smsFrom;
  String? baseColor;
  String? secondaryColor;
  MyBankBeneficiaryGlobalShortcodes? globalShortcodes;
  int? kv;
  int? ev;
  int? en;
  int? sv;
  int? sn;
  int? forceSsl;
  int? maintenanceMode;
  int? securePassword;
  int? agree;
  int? registration;
  String? activeTemplate;
  MyBankBeneficiaryModules? modules;
  int? accountNoLength;
  String? accountNoPrefix;
  String? otpTime;
  String? minBalanceLimit;
  String? maxBalanceLimit;
  String? dailyTransferLimit;
  String? monthlyTransferLimit;
  String? minimumTransferLimit;
  String? fixedTransferCharge;
  String? percentTransferCharge;
  String? commissionUserType;
  String? commissionAccountType;
  String? bounceCalcOn;
  String? kycardCommissionCalcOn;
  String? agentCardPrice;
  int? referralCommissionCount;
  int? userReferralPoint;
  String? lastDpsCron;
  String? lastFdrCron;
  String? lastLoanCron;
  dynamic createdAt;
  String? updatedAt;

  MyBankBeneficiaryGeneral({
    this.id,
    this.siteName,
    this.curText,
    this.curSym,
    this.emailFrom,
    this.smsBody,
    this.smsFrom,
    this.baseColor,
    this.secondaryColor,
    this.globalShortcodes,
    this.kv,
    this.ev,
    this.en,
    this.sv,
    this.sn,
    this.forceSsl,
    this.maintenanceMode,
    this.securePassword,
    this.agree,
    this.registration,
    this.activeTemplate,
    this.modules,
    this.accountNoLength,
    this.accountNoPrefix,
    this.otpTime,
    this.minBalanceLimit,
    this.maxBalanceLimit,
    this.dailyTransferLimit,
    this.monthlyTransferLimit,
    this.minimumTransferLimit,
    this.fixedTransferCharge,
    this.percentTransferCharge,
    this.commissionUserType,
    this.commissionAccountType,
    this.bounceCalcOn,
    this.kycardCommissionCalcOn,
    this.agentCardPrice,
    this.referralCommissionCount,
    this.userReferralPoint,
    this.lastDpsCron,
    this.lastFdrCron,
    this.lastLoanCron,
    this.createdAt,
    this.updatedAt,
  });

  factory MyBankBeneficiaryGeneral.fromJson(Map<String, dynamic> json) =>
      MyBankBeneficiaryGeneral(
        id: json['id'],
        siteName: json['site_name'],
        curText: json['cur_text'],
        curSym: json['cur_sym'],
        emailFrom: json['email_from'],
        smsBody: json['sms_body'],
        smsFrom: json['sms_from'],
        baseColor: json['base_color'],
        secondaryColor: json['secondary_color'],
        globalShortcodes: MyBankBeneficiaryGlobalShortcodes.fromJson(
            json['global_shortcodes']),
        kv: json['kv'],
        ev: json['ev'],
        en: json['en'],
        sv: json['sv'],
        sn: json['sn'],
        forceSsl: json['force_ssl'],
        maintenanceMode: json['maintenance_mode'],
        securePassword: json['secure_password'],
        agree: json['agree'],
        registration: json['registration'],
        activeTemplate: json['active_template'],
        modules: MyBankBeneficiaryModules.fromJson(json['modules']),
        accountNoLength: json['account_no_length'],
        accountNoPrefix: json['account_no_prefix'],
        otpTime: json['otp_time'],
        minBalanceLimit: json['min_balance_limit'],
        maxBalanceLimit: json['max_balance_limit'],
        dailyTransferLimit: json['daily_transfer_limit'],
        monthlyTransferLimit: json['monthly_transfer_limit'],
        minimumTransferLimit: json['minimum_transfer_limit'],
        fixedTransferCharge: json['fixed_transfer_charge'],
        percentTransferCharge: json['percent_transfer_charge'],
        commissionUserType: json['commission_user_type'],
        commissionAccountType: json['commission_account_type'],
        bounceCalcOn: json['bounce_calc_on'],
        kycardCommissionCalcOn: json['kycard_commission_calc_on'],
        agentCardPrice: json['agent_card_price'],
        referralCommissionCount: json['referral_commission_count'],
        userReferralPoint: json['user_referral_point'],
        lastDpsCron: json['last_dps_cron'],
        lastFdrCron: json['last_fdr_cron'],
        lastLoanCron: json['last_loan_cron'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'site_name': siteName,
    'cur_text': curText,
    'cur_sym': curSym,
    'email_from': emailFrom,
    'sms_body': smsBody,
    'sms_from': smsFrom,
    'base_color': baseColor,
    'secondary_color': secondaryColor,
    'global_shortcodes': globalShortcodes?.toJson(),
    'kv': kv,
    'ev': ev,
    'en': en,
    'sv': sv,
    'sn': sn,
    'force_ssl': forceSsl,
    'maintenance_mode': maintenanceMode,
    'secure_password': securePassword,
    'agree': agree,
    'registration': registration,
    'active_template': activeTemplate,
    'modules': modules?.toJson(),
    'account_no_length': accountNoLength,
    'account_no_prefix': accountNoPrefix,
    'otp_time': otpTime,
    'min_balance_limit': minBalanceLimit,
    'max_balance_limit': maxBalanceLimit,
    'daily_transfer_limit': dailyTransferLimit,
    'monthly_transfer_limit': monthlyTransferLimit,
    'minimum_transfer_limit': minimumTransferLimit,
    'fixed_transfer_charge': fixedTransferCharge,
    'percent_transfer_charge': percentTransferCharge,
    'commission_user_type': commissionUserType,
    'commission_account_type': commissionAccountType,
    'bounce_calc_on': bounceCalcOn,
    'kycard_commission_calc_on': kycardCommissionCalcOn,
    'agent_card_price': agentCardPrice,
    'referral_commission_count': referralCommissionCount,
    'user_referral_point': userReferralPoint,
    'last_dps_cron': lastDpsCron,
    'last_fdr_cron': lastFdrCron,
    'last_loan_cron': lastLoanCron,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class MyBankBeneficiaryGlobalShortcodes {
  String? activeEmailSubject;
  String? passwordResetSubject;
  String? passwordResetMessage;
  String? passwordResetFrom;

  MyBankBeneficiaryGlobalShortcodes({
    this.activeEmailSubject,
    this.passwordResetSubject,
    this.passwordResetMessage,
    this.passwordResetFrom,
  });

  factory MyBankBeneficiaryGlobalShortcodes.fromJson(
      Map<String, dynamic> json) =>
      MyBankBeneficiaryGlobalShortcodes(
        activeEmailSubject: json['active_email_subject'],
        passwordResetSubject: json['password_reset_subject'],
        passwordResetMessage: json['password_reset_message'],
        passwordResetFrom: json['password_reset_from'],
      );

  Map<String, dynamic> toJson() => {
    'active_email_subject': activeEmailSubject,
    'password_reset_subject': passwordResetSubject,
    'password_reset_message': passwordResetMessage,
    'password_reset_from': passwordResetFrom,
  };
}

class MyBankBeneficiaryModules {
  int? deposit;
  int? withdrawal;
  int? transfer;
  int? refBy;
  int? kyc;

  MyBankBeneficiaryModules({
    this.deposit,
    this.withdrawal,
    this.transfer,
    this.refBy,
    this.kyc,
  });

  factory MyBankBeneficiaryModules.fromJson(Map<String, dynamic> json) =>
      MyBankBeneficiaryModules(
        deposit: json['deposit'],
        withdrawal: json['withdrawal'],
        transfer: json['transfer'],
        refBy: json['ref_by'],
        kyc: json['kyc'],
      );

  Map<String, dynamic> toJson() => {
    'deposit': deposit,
    'withdrawal': withdrawal,
    'transfer': transfer,
    'ref_by': refBy,
    'kyc': kyc,
  };
}
