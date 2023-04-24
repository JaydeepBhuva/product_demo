import 'dart:collection';

class UserData {
  String? key, mobileNumber, password;

  UserData({
    this.key,
    this.mobileNumber,
    this.password,
  });

  factory UserData.fromJson(Map<dynamic, dynamic> json) => UserData(
        key: json["key"],
        mobileNumber: json["mobileNumber"],
        password: json["password"],
      );

  Map<dynamic, dynamic> toJson() {
    Map<dynamic, dynamic> data = HashMap();
    if (key != null) {
      data["key"] = key;
    }
    if (mobileNumber != null) {
      data["mobileNumber"] = mobileNumber;
    }
    if (password != null) {
      data["password"] = password;
    }
    return data;
  }
}
