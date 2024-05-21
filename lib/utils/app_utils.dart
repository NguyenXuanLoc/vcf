import 'package:base_bloc/data/repository/base_repository.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hl_image_picker/hl_image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart'
    as image_compress;
import '../data/eventbus/refresh_event.dart';
import '../data/globals.dart' as globals;
import '../data/model/user_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class Utils {
  static var eventBus = EventBus();
  static const platform = MethodChannel('plugins.flutter.io/navigator');
  static var repository = BaseRepository();

  static fireEvent(dynamic model) => eventBus.fire(model);

  static bool validatePassword(String value) {
    String pattern = r'^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[0-9]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static void hideKeyboard(BuildContext? context) {
    if (context != null) FocusScope.of(context).requestFocus(FocusNode());
  }

  static void openUrl(String url,
      {LaunchMode launchMode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: launchMode);
    }
  }

  static String formatMoney(int? money) =>
      NumberFormat('#,###,###,#,###,###,###', 'vi').format(money ?? 0) + " VNĐ";

  static String formatDateFromAToB(DateTime? from, DateTime? to) =>
      DateFormat('dd').format(from ?? DateTime.now()) +
      "-" +
      DateFormat('dd.MM.yyyy').format(to ?? DateTime.now());

  static String formatDateToddMMYYYY(DateTime? date) =>
      DateFormat('dd.MM.yyyy').format(date ?? DateTime.now());

  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{9,12}$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static bool isGetUserInfoSuccess = false;

  static Future<void> getUserInfo() async {
    try {
      if (globals.isLogin && isGetUserInfoSuccess == false) {
        var response = await repository.getUserProfile();
        if (response.error == null) {
          var userModel = UserModel.fromJson(response.data);
          await StorageUtils.saveUserModel(userModel);
          Utils.fireEvent(RefreshEvent(refreshType: RefreshType.HOME));
        }
        isGetUserInfoSuccess = true;
      }
    } catch (ex) {}
  }

  static int getAgeByBirthDay(DateTime? age) {
    age = age ?? DateTime.now();
    var result = DateTime.now().year - age.year;
    return result == 0 ? 1 : result;
  }

  static Future<String?> compressFile(String path) async {
    final dir = await path_provider.getTemporaryDirectory();
    final result = await image_compress.FlutterImageCompress.compressAndGetFile(
      path,
      "${dir.absolute.path}/${path.split('/').last}",
      quality: 50,
      minWidth: 1024,
      minHeight: 1024,
    );

    if (result == null) return null;
    logE("TAG PATH: $result");
    return result.path;
  }

  static Future<HLPickerItem?> openPicker() async {
    var _picker = HLImagePicker();
    try {
      final images = await _picker.openPicker(
          cropping: false,
          pickerOptions: const HLPickerOptions(
            mediaType: MediaType.image,
            enablePreview: true,
            thumbnailCompressFormat: CompressFormat.jpg,
            thumbnailCompressQuality: 0.9,
            maxSelectedAssets: 1,
            usedCameraButton: true,
            numberOfColumn: 3,
            isGif: true,
          ));
      if (images.isNotEmpty) return images.first;
      logE("TAG images.length: ${images.length}");
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
