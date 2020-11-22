import 'package:meta/meta.dart';
import 'package:vk_bridge/src/bridge/logger.dart';
import 'package:vk_bridge/src/bridge/vk_bridge.dart' as vk_bridge;
import 'package:vk_bridge/src/data/model/events/vk_web_app_update_config/vk_web_app_update_config.dart';
import 'package:vk_bridge/src/data/model/launch_params.dart';
import 'package:vk_bridge/src/data/model/options/show_story_box_options/show_story_box_options.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_bool_result/vk_web_app_bool_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_client_version_result/vk_web_app_get_client_version_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_email_result/vk_web_app_get_email_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_geodata_result/vk_web_app_get_geodata_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_user_info_result/vk_web_app_get_user_info_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_share_result/vk_web_app_share_result.dart';

/// This is the stub implementation where every method throws UnsupportedError
class VKBridge implements vk_bridge.VKBridge {
  static final _unsupportedError = UnsupportedError('VK Bridge only for web');

  @override
  void setLogger(Logger logger) => throw _unsupportedError;

  @override
  LaunchParams get launchParams => throw _unsupportedError;

  @override
  String get launchHash => throw _unsupportedError;

  @override
  Future<VKWebAppBoolResult> init() => throw _unsupportedError;

  @override
  Future<VKWebAppGetUserInfoResult> getUserInfo() => throw _unsupportedError;

  @override
  Future<VKWebAppGetEmailResult> getEmail() => throw _unsupportedError;

  @override
  Future<VKWebAppGetClientVersionResult> getClientVersion() =>
      throw _unsupportedError;

  @override
  Future<VKWebAppShareResult> share([String link]) => throw _unsupportedError;

  @override
  Stream<VKWebAppUpdateConfig> get updateConfigStream =>
      throw _unsupportedError;

  @override
  Future<VKWebAppBoolResult> showImages(
    List<String> images, {
    int startIndex,
  }) =>
      throw _unsupportedError;

  @override
  Future<VKWebAppBoolResult> downloadFile({
    @required String url,
    @required String filename,
  }) =>
      throw _unsupportedError;

  @override
  Future<VKWebAppBoolResult> copyText(String text) => throw _unsupportedError;

  @override
  Future<VKWebAppGetGeodataResult> getGeodata() => throw _unsupportedError;

  @override
  Future showStoryBox(ShowStoryBoxOptions options) => throw _unsupportedError;

  @override
  Future<VKWebAppBoolResult> allowNotifications() => throw _unsupportedError;

  @override
  Future<VKWebAppBoolResult> denyNotifications() => throw _unsupportedError;
}
