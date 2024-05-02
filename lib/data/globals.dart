library app.globals;

import 'package:flutter/cupertino.dart';

import 'model/user_model.dart';

String accessToken = '';
String refreshToken = '';
String lang = '';
String deviceId = '';
String deviceName = '';
String deviceModel = '';
BuildContext? homeContext;
bool popWithNewAnimation = false;
bool isQrCode = false;
bool isLogin = false;
UserModel? userModel;
bool isTokenExpired = false;
int timeOut = 30;
double contentPadding = 14;
double paddingBottomNav = 90;
