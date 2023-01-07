
import 'dart:ffi';

import 'models/used_app.dart';
import 'test_flutter_plugin_platform_interface.dart';

class TestFlutterPlugin {
  Future<String?> getPlatformVersion() {
    return TestFlutterPluginPlatform.instance.getPlatformVersion();
  }

  Future<double?> getBatteryLevel() {
    return TestFlutterPluginPlatform.instance.getBatteryLevel();
  }

  Future<List<UsedApp>> get apps {
    return TestFlutterPluginPlatform.instance.apps;
  }

  Future<String> setAppTimeLimit(String appId, Duration duration) {
    return TestFlutterPluginPlatform.instance.setAppTimeLimit(appId, duration);
  }
}