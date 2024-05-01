library app.globals;

import 'package:flutter/cupertino.dart';

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
bool isTokenExpired = false;
int timeOut = 30;
double contentPadding = 14;
