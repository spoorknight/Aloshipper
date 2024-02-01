class UserBankAccountModel {
  bool? status;
  String? mess;
  BankAccount? data;

  UserBankAccountModel({this.status, this.mess, this.data});

  UserBankAccountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    mess = json['mess'];
    if (json['data'] != null) {
      data = BankAccount.fromJson(json['data']);
    }
  }

  bool get isHasData => data != null;

  String get getUserBankName => data?.userBankName ?? '';

  String get getUserBankNumber => data?.userBankNumber ?? '';

  String get getBankId => data?.bankId ?? '';
}

class BankAccount {
  String? userBankName;
  String? userBankNumber;
  String? bankId;
  String? id;
  String? userId;

  BankAccount(
      {this.userBankName,
      this.userBankNumber,
      this.bankId,
      this.id,
      this.userId});

  BankAccount.fromJson(Map<String, dynamic> json) {
    userBankName = json['user_bank_name'];
    userBankNumber = json['user_bank_number'];
    bankId = json['bank_id'];
    id = json['id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_bank_name'] = userBankName;
    data['user_bank_number'] = userBankNumber;
    data['bank_id'] = bankId;
    data['id'] = id;
    data['user_id'] = userId;
    return data;
  }

  String get getUserBankName => userBankName ?? '';

  String get getUserBankNumber => userBankNumber ?? '';
}
