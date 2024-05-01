import 'dart:io';

class StorageKey {
  StorageKey._();
}

class FirebaseRemoteConfigConstant {
  static String FACEBOOK_ERROR_CODE_VALUE =
      "PLATFORM__LOGIN_DISABLED_FROM_WEBVIEW"; //error code when trying login with facebook inside instagram web
  static const FACEBOOK_ERROR_CODE_KEY = "FACEBOOK_ERROR_CODE";
  static const FACEBOOK_ERROR_CODE = "FACEBOOK_ERROR_CODE";
  static const APPLE_ID_KEY = "APPLE_ID_KEY";
  static String APPLE_ID_VALUE = "6479729407";
  static String ANDROID_REVIEW_VERSION_KEY = "Android_review_version";
  static String REVIEW_VERSION = "";
  static String IOS_REVIEW_VERSION_KEY = "Ios_review_version";
  static String INSTAGRAM_REVIEW_MODEL_KEY = "Instagram_review_model";
  static String INSTAGRAM_REVIEW_VERSION_VALUE = "";
  static String ANDROID_STORE_VERSION_KEY = "Android_store_version";
  static String IOS_STORE_VERSION_KEY = "Ios_store_version";
  static String STORE_VERSION = "";
}

class BottomNavigationConstant {
  static const TAB_HOME = 0;
  static const TAB_RACE = 1;
  static const TAB_ATHLETE = 2;
  static const TAB_PROFILE = 3;
}

class ConstantKey {
  static const String All = 'all';
  static const RESTAURANT_NOT_FOUND = 0;
  static const appName = "VCF";
}

class MessageKey {
  static const String egCodeIsValid = 'Twoja sesja wygasła';
  static const String plCodeIsValid = 'Your code is invalid';
}

class ApiKey {}
