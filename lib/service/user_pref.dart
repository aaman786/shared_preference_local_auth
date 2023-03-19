import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../utils/snack_bar.dart';

class UserPreference {
  static late SharedPreferences preferences;

  static Future init() async =>
      preferences = await SharedPreferences.getInstance();

  static void setUser(BuildContext context, UserModel user) {
    final json = jsonEncode(user.toJson());
    final uid = user.phNumber;
    preferences
        .setString(uid, json)
        .then((value) => showSnackBar(context, "Registration succesfull..."));
  }

  static UserModel? getUser(String uid) {
    final json = preferences.getString(uid);

    if (json == null) {
      return null;
    }

    return UserModel.fromJson(jsonDecode(json));
  }
}
