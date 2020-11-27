import 'package:meta/meta.dart';
import 'package:vk_bridge/src/bridge/logger.dart';
import 'package:vk_bridge/src/data/model/events/vk_web_app_update_config/vk_web_app_update_config.dart';
import 'package:vk_bridge/src/data/model/launch_params.dart';
import 'package:vk_bridge/src/data/model/options/show_story_box_options/show_story_box_options.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_add_to_community_result/vk_web_app_add_to_community_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_add_to_home_screen_info_result/vk_web_app_add_to_home_screen_info_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_bool_result/vk_web_app_bool_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_community_access_token_result/vk_web_app_community_access_token_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_contacts_done/vk_web_app_contacts_done.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_flash_get_info_result/vk_web_app_flash_get_info_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_auth_token_result/vk_web_app_get_auth_token_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_client_version_result/vk_web_app_get_client_version_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_email_result/vk_web_app_get_email_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_friends_result/vk_web_app_get_friends_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_geodata_result/vk_web_app_get_geodata_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_group_info_result/vk_web_app_get_group_info_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_personal_card_result/vk_web_app_get_personal_card_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_phone_number_result/vk_web_app_get_phone_number_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_get_user_info_result/vk_web_app_get_user_info_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_open_app_result/vk_web_app_open_app_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_open_code_reader_result/vk_web_app_open_code_reader_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_share_result/vk_web_app_share_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_show_wall_post_box_result/vk_web_app_show_wall_post_box_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_storage_get_keys_result/vk_web_app_storage_get_keys_result.dart';
import 'package:vk_bridge/src/data/model/results/vk_web_app_storage_get_result/vk_web_app_storage_get_result.dart';

import 'vk_bridge_web.dart' if (dart.library.io) 'unsupported.dart'
    as vk_bridge;

/// Contact for interacting with VK Mini Aps platform
/// Original VK documentation here: https://vk.com/dev/vk_bridge_events
abstract class VKBridge {
  /// Set the [logger] as logger
  /// The package can print debug and error logs at runtime
  void setLogger(Logger logger);

  /// Singleton of the VK Bridge
  static final VKBridge instance = vk_bridge.VKBridge();

  /// When the service is started, additional parameters are passed to the URL
  /// specified in the application control, containing data about the user and
  /// the source of launch
  LaunchParams get launchParams;

  /// When starting the service, an additional hash parameter can be passed to
  /// the URL specified in the application control
  String get launchHash;

  /// Stream with VKWebAppUpdateConfig events:
  /// The client dispatches a [VKWebAppUpdateConfig] event to the application
  /// with information about the theme being used in the following cases:
  /// - immediately after [VKWebAppInit]
  /// - when showing a modal view controller;
  /// - when the keyboard appears / disappears / resizes
  /// - when changing the screen frame (including orientation)
  /// - when changing the color scheme
  Stream<VKWebAppUpdateConfig> get updateConfigStream;

  /// [VKWebAppInit] - the first event that your application must send to the
  /// official application to start working with VK Bridge. Otherwise, the
  /// service may not work on iOS and Android mobile clients.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  Future<VKWebAppBoolResult> init();

  /// [VKWebAppGetUserInfo] allows you to get basic data about the current user
  /// profile.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  Future<VKWebAppGetUserInfoResult> getUserInfo();

  /// [VKWebAppGetEmail] allows you to get the user's email address. After the
  /// call, it displays a screen asking for permission to access e-mail.
  ///
  /// Platforms: iOS, Android, Web
  Future<VKWebAppGetEmailResult> getEmail();

  /// [VKWebAppGetClientVersion] returns the version number of the official VK
  /// application.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  Future<VKWebAppGetClientVersionResult> getClientVersion();

  /// [VKWebAppShare] allows you to share a link.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [link] the link to share
  /// (by default - the current link in the form of https://vk.com/app123#hash)
  Future<VKWebAppShareResult> share([String link]);

  /// [VKWebAppShowImages] opens the native screen for viewing images.
  ///
  /// Platforms: iOS, Android, Mobile Web
  ///
  /// [images] array of strings containing image URLs.
  /// [startIndex] index of the image from which to start displaying, starting
  /// from 0.
  Future<VKWebAppBoolResult> showImages(
    List<String> images, {
    int startIndex,
  });

  /// Raising the [VKWebAppDownloadFile] event allows you to download a file to
  /// the device.
  ///
  /// Platforms: iOS, Android
  ///
  /// [url] link to the file to download.
  /// [filename] file name.
  Future<VKWebAppBoolResult> downloadFile({
    @required String url,
    @required String filename,
  });

  /// Raising the [VKWebAppCopyText] event allows you to copy text to the
  /// clipboard.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  /// [text] the text to copy
  ///
  Future<VKWebAppBoolResult> copyText(String text);

  /// [VKWebAppGetGeodata] allows you to get data about the user's geolocation.
  /// The event takes no parameters. The official app shows a window asking for
  /// permission to transfer location.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  Future<VKWebAppGetGeodataResult> getGeodata();

  /// [VKWebAppShowStoryBox] opens the story editor
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  Future<dynamic> showStoryBox(ShowStoryBoxOptions options);

  /// [VKWebAppAllowNotifications] allows you to ask the user for permission
  /// to send notifications from the app.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  Future<VKWebAppBoolResult> allowNotifications();

  /// [VKWebAppDenyNotifications] allows you
  /// to disable notifications from an app.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  Future<VKWebAppBoolResult> denyNotifications();

  /// [VKWebAppShowWallPostBox] allows the user to post to the wall.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [message] message which will be posted
  Future<VKWebAppShowWallPostBoxResult> showWallPostBox(String message);

  /// [VKWebAppAddToFavorites] invokes a request window
  /// for adding a service to favorites.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  Future<VKWebAppBoolResult> addToFavorites();

  /// [VKWebAppOpenCodeReader] allows you to open the camera
  /// to read the QR code and get the scan result.
  ///
  /// Platforms: iOS, Android
  Future<VKWebAppOpenCodeReaderResult> openCodeReader();

  /// [VKWebAppOpenApp] allows you to open another app
  /// from the current VK Mini Apps.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [appId] the identifier of the application to be opened.
  /// [location] hash, the line after the # in a URL,
  /// like https://vk.com/app123456#.
  Future<VKWebAppBoolResult> openApp({
    @required int appId,
    String location,
  });

  /// [VKWebAppClose] If the application was launched using
  /// the [VKWebAppOpenApp] event, then the parent application will receive
  /// the VKWebAppOpenAppResult event when VKWebAppClose is called.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [status] the application close status passed to the parent application.
  /// Possible values: Possible values: failed, success
  /// [payload] data passed to the parent application.
  Future<VKWebAppOpenAppResult> close({
    String status,
    Object payload,
  });

  /// Calling the [VKWebAppAddToHomeScreenInfo] event
  /// allows you to get information
  /// about adding a shortcut to the device's home screen.
  ///
  /// Platforms: Android
  Future<VKWebAppAddToHomeScreenInfoResult> addToHomeScreenInfo();

  /// Calling the [VKWebAppAddToHomeScreen] event
  /// allows you to add VK Mini Apps to the device screen.
  /// Platforms: Android
  Future<VKWebAppBoolResult> addToHomeScreen();

  /// Calling the [VKWebAppSendToClient] event allows you to send a notification to open a service on a mobile device.
  ///
  /// Platforms: Web, Mobile Web
  ///
  /// [fragment] hash in the notification. (https://vk.com/appXXXX#fragment)
  Future<VKWebAppBoolResult> sendToClient([String fragment]);

  /// "Contact card" is the place where the user indicates contact information
  /// (phone number, address, e-mail),
  /// which he is ready to share with third-party services.
  ///
  /// The data in the contact card is not linked to the profile data
  /// and lives independently of it. At the same time,
  /// in the interface of your application, the user will be able to choose
  /// which data from the card to provide or edit data directly
  /// in the process of requesting access rights.
  ///
  /// [VKWebAppGetPersonalCard] calls the user's contact card
  /// with the fields that you requested.
  /// The official app displays a screen asking for the user's permission
  /// to transfer the selected data to the app.
  ///
  /// Platforms: iOS, Android
  ///
  /// [type] array of strings. Possible values:
  /// phone - phone number.
  /// email - mailing address.
  /// address - user's address.
  Future<VKWebAppGetPersonalCardResult> getPersonalCard(List<String> type);

  /// Calling the [VKWebAppSendToClient] event allows you to send a notification to open a service on a mobile device.
  ///
  /// Platforms: Web, Mobile Web
  ///
  /// [fragment] hash in the notification. (https://vk.com/appXXXX#fragment)
  Future<VKWebAppGetPhoneNumberResult> getPhoneNumber();

  /// [VKWebAppStorageGet] returns the values of the variables,
  /// the names of which were passed in the keys parameter.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [keys] - the names of the keys, [a-zA-Z _ \ - 0-9],
  /// passed in an array of strings.
  Future<VKWebAppStorageGetResult> storageGet(List<String> keys);

  /// The [VKWebAppStorageSet] call stores the value of the variable
  /// whose name is passed in the key parameter.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [key] - key name, [a-zA-Z _ \ - 0-9]. The maximum length is 100 characters.
  /// [value] - variable value, only the first 4096 bytes are saved.
  Future<VKWebAppBoolResult> storageSet({
    @required String key,
    String value,
  });

  /// Call [VKWebAppStorageGetKeys] returns the names of all variables.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [count] - the number of variable names to get information about.
  /// [offset] - the offset required to sample a specific subset of variable names.
  Future<VKWebAppStorageGetKeysResult> storageGetKeys({
    int count,
    int offset,
  });

  /// [VKWebAppGetFriends] brings up a selection window from the friends list.
  ///
  /// Platforms: iOS, Android, Web
  ///
  /// [multi] -
  /// false: selection of one friend from the list.
  /// true: selection of several friends from the list.
  /// The default is false.
  Future<VKWebAppGetFriendsResult> getFriends([bool multi = false]);

  /// [VKWebAppOpenContacts] opens a window for selecting contacts
  /// from the phone book on the user's device.
  ///
  /// Platforms: iOS, Android
  Future<VKWebAppContactsDone> openContacts();

  /// [VKWebAppGetAuthToken] allows you to request access rights from the user
  /// and get a key to work with the API. At the same time,
  /// you do not need to request a token to identify a user in the service.
  /// Use the signature of the launch parameters for this
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [app_id] - application ID.
  /// [scope] - list of access rights, separated by commas.
  /// To get a token without additional rights,
  /// pass an empty string in the parameter. Available Values:
  /// friends - access to the user's friends list,
  /// photos - access to photos,
  /// video - access to videos,
  /// stories - access to stories,
  /// pages - access to wiki pages,
  /// status - access to user status,
  /// notes - access to user notes,
  /// wall - to methods of working with a wall,
  /// docs - access to documents,
  /// groups - access to user communities,
  /// stats - access to statistics of groups and applications of the user, of which he is the administrator,
  /// market - access to goods.
  ///
  // TODO: Set<Scope> scopes
  Future<VKWebAppGetAuthTokenResult> getAuthToken({
    @required int appId,
    @required String scope,
  });

  /// [VKWebAppGetGroupInfo] allows you to get information about the group.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [groupId] - group ID.
  Future<VKWebAppGetGroupInfoResult> getGroupInfo(int groupId);

  /// [VKWebAppJoinGroup] allows the user to join the community.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [groupId] - group ID.
  Future<VKWebAppBoolResult> joinGroup(int groupId);

  /// [VKWebAppLeaveGroup] allows the user to log out of the community.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [groupId] - group ID.
  Future<VKWebAppBoolResult> leaveGroup(int groupId);

  /// [VKWebAppAllowMessagesFromGroup] allows you to request permission
  /// from the user to send messages on behalf of the community.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [groupId] - group ID.
  /// [key] - arbitrary string.
  /// This parameter can be used to authenticate the user.
  /// Its value will be returned in the message_allow event of the Callback API.
  Future<VKWebAppBoolResult> allowMessagesFromGroup({
    @required int groupId,
    String key,
  });

  /// [VKWebAppGetCommunityToken] allows you to request access rights
  /// and get a key to work with the API on behalf of the community.
  /// Only the community administrator can obtain a community access token.
  ///
  /// For further work, get the access key of the user
  /// with scope = groups rights and make a request to the groups.get method
  /// with the filter = admin parameter to get a list of the IDs
  /// of the administered groups.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  ///
  /// [appId] - app ID.
  /// [groupId] - group ID.
  /// [scope] - list of access rights, separated by commas.
  /// Available Values:
  /// stories - access to stories.
  /// photos - access to photos.
  /// app_widget - Access to community widgets.
  /// messages - access to community messages.
  /// docs - access to documents.
  /// manage - access to community administration.
  Future<VKWebAppCommunityAccessTokenResult> getCommunityToken({
    @required int appId,
    @required int groupId,
    @required String scope,
  });

  /// [VKWebAppAddToCommunity] calls the community selection window
  /// for installing the service.
  ///
  /// Please note: to call in the application management
  /// https://vk.com/editapp?id={app_id} the checkbox next
  /// to "Allow installation in communities" must be set.
  /// The app must be enabled and accessible to everyone.
  ///
  /// Platforms: iOS, Android, Web, Mobile Web
  Future<VKWebAppAddToCommunityResult> addToCommunity();

  /// Raising the [VKWebAppShowCommunityWidgetPreviewBox] event
  /// brings up the community widget preview screen.
  /// Community app widgets have a separate guide.
  /// ( https://vk.com/dev/apps_widgets )
  ///
  /// Please note: to call in the application management
  /// https://vk.com/editapp?id={app_id} the checkbox next
  /// to "Allow installation in communities" must be set.
  /// The app must be enabled and accessible to everyone.
  ///
  /// [groupId] - group ID.
  /// [type] - Widget type. Can take values:
  /// text,
  /// list,
  /// table,
  /// tiles,
  /// compact_list,
  /// cover_list,
  /// match,
  /// matches,
  /// donation.
  /// [code] - Widget code.
  /// Analogue of the code parameter in the execute method.
  /// The parameters of all supported widget types
  /// are described in detail on this page.
  /// ( https://vk.com/dev/objects/appWidget )
  ///
  /// Platforms: iOS, Android, Web
  Future<VKWebAppBoolResult> showCommunityWidgetPreviewBox({
    @required int groupId,
    @required String type,
    @required String code,
  });

  /// [VKWebAppFlashGetInfo] asks for information about the flashlight.
  ///
  /// Platforms: iOS, Android
  Future<VKWebAppFlashGetInfoResult> flashGetInfo();

  /// [VKWebAppFlashSetLevel] sets the brightness level of the flashlight.
  ///
  /// [level] - flashlight brightness level from 0 to 1.
  ///
  /// Platforms: iOS, Android
  Future<VKWebAppBoolResult> flashSetLevel(int level);
}
