import 'package:firebase_database/firebase_database.dart';
import 'package:product_demo/data/model/user_model.dart';

class UserDataApi {
  static final firebaseDatabase = FirebaseDatabase.instance.ref('user');

  static List<UserData> userDataList = [];

  static Future<void> addData(UserData userData) async {
    String key = firebaseDatabase.push().key!;
    userData.key = key;
    await firebaseDatabase.child(key).set(userData.toJson());
  }

  static Future<void> profileData() async {
    DataSnapshot response = await firebaseDatabase.get();
    Map data = response.value as Map? ?? {};
    userDataList.clear();
    data.forEach((key, value) {
      userDataList.add(UserData.fromJson(value));
    });
  }
}
