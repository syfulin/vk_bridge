// @JS('vkBridge')
@JS()
library vkBridge;

import 'dart:convert';
import 'dart:html';
import 'dart:js_util';

import 'package:js/js.dart';
import 'package:vk_bridge/src/bridge/vk_bridge.dart' as vkBridge;
import 'package:vk_bridge/src/data/model/errors/vk_web_app_error.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_bool_result/vk_web_app_bool_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_client_version_result/vk_web_app_get_client_version_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_email_result/vk_web_app_get_email_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_user_info_result/vk_web_app_get_user_info_result.dart';
import 'package:vk_bridge/src/data/model/serializers.dart';
import 'package:vk_bridge/src/utils.dart';

@JS("vkBridge.send")
external _send(String method, [Object props]);

class VKBridge implements vkBridge.VKBridge {
  // TODO: добавить модель
  String _launchParams;

  @override
  String get launchParams => _launchParams;

  static Future<Result> _sendInternal<Result, Options>(
    String method, [
    Options props,
  ]) async {
    assert(Result.toString() != "dynamic", "Result type can't be dynamic.");
    assert(
      props == null || Options.toString() != "dynamic",
      "Options type can't be dynamic.",
    );

    print("vk_bridge: _sendInternal($method)");

    try {
      final propsJson =
          props == null ? "{}" : jsonEncode(serialize<Options>(props));

      print("vk_bridge: send($method, $propsJson)");

      final jsObjectResult =
          await promiseToFuture(_send(method, parse(propsJson)));
      final jsonResult = stringify(jsObjectResult);
      final decodedJson = jsonDecode(jsonResult);
      try {
        final result = deserialize<Result>(decodedJson);
        print("vk_bridge: send($method) result: $result");
        return result;
      } catch (e) {
        print("vk_bridge: send($method) jsonResult: $jsonResult");
        throw e;
      }
    } catch (jsObjectError) {
      final jsonError = stringify(jsObjectError);
      final decodedJson = jsonDecode(jsonError);

      VKWebAppError error;
      try {
        error = deserialize<VKWebAppError>(decodedJson);
      } catch (e) {
        print("vk_bridge: send($method) jsonError: $jsonError");
        print("vk_bridge: can't deserialize error");
        throw e;
      }

      print("vk_bridge: send($method) error: $error");
      throw error;
    }
  }

  @override
  Future<VKWebAppBoolResult> init() async {
    final VKWebAppBoolResult vkWebAppInitResult = await _sendInternal(
      'VKWebAppInit',
    );

    /// https://vk.cc/9AjsnM
    _launchParams = window.location.search;
    if (_launchParams.startsWith('\?')) {
      _launchParams = launchParams.substring(1);
    }
    return vkWebAppInitResult;
  }

  @override
  Future<VKWebAppGetUserInfoResult> getUserInfo() {
    return _sendInternal('VKWebAppGetUserInfo');
  }

  @override
  Future<VKWebAppGetEmailResult> getEmail() {
    return _sendInternal('VKWebAppGetEmail');
  }

  @override
  Future<VKWebAppGetClientVersionResult> getClientVersion() {
    return _sendInternal('VKWebAppGetClientVersion');
  }
//
// static Future<VKWebAppAllowNotificationsResult> allowNotifications() {
//   return _sendInternal('VKWebAppAllowNotifications');
// }
//
// static Future<VKWebAppShareResult> share([String link]) {
//   return _sendInternal(
//     'VKWebAppShare',
//     // ShareOptions(link: link),
//   );
// }
//
// static Future<void> showImages() {
//   return _sendInternal(
//     'VKWebAppShowImages',
//     // ShowImagesOptions(
//     //   images: [
//     //     "https://pp.userapi.com/c639229/v639229113/31b31/KLVUrSZwAM4.jpg",
//     //     "https://pp.userapi.com/c639229/v639229113/31b94/mWQwkgDjav0.jpg",
//     //     "https://pp.userapi.com/c639229/v639229113/31b3a/Lw2it6bdISc.jpg"
//     //   ],
//     // ),
//   );
//   // }
// }
//
// static Future<dynamic> showStoryBox() {
//   return _sendInternal(
//     'VKWebAppShowStoryBox',
//     // StoryOptions(
//     //   background_type: "image",
//     //   url:
//     //       "https://sun9-65.userapi.com/c850136/v850136098/1b77eb/0YK6suXkY24.jpg",
//     // ),
//   );
// }
}