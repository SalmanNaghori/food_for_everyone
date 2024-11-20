import 'dart:developer';
import 'dart:io';
import 'package:html/dom.dart';
import 'package:upgrader/upgrader.dart';

class VersionStatus {
  Future<String?> getStoreVersion(String myAppBundleId) async {
    String? storeVersion;
    if (Platform.isAndroid) {
      PlayStoreSearchAPI playStoreSearchAPI = PlayStoreSearchAPI();
      Document? result =
      await playStoreSearchAPI.lookupById(myAppBundleId, country: 'IN');
      if (result != null) storeVersion = playStoreSearchAPI.version(result);
      log('PlayStore version: $storeVersion');
    } else if (Platform.isIOS) {
      ITunesSearchAPI iTunesSearchAPI = ITunesSearchAPI();
      Map<dynamic, dynamic>? result =
      await iTunesSearchAPI.lookupByBundleId(myAppBundleId, country: 'IN');
      if (result != null) storeVersion = iTunesSearchAPI.version(result);
      log('AppStore version: $storeVersion');
    } else {
      storeVersion = null;
    }
    return storeVersion;
  }
}