import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'models/used_app.dart';
import 'test_flutter_plugin_platform_interface.dart';

/// An implementation of [TestFlutterPluginPlatform] that uses method channels.
class MethodChannelTestFlutterPlugin extends TestFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('test_flutter_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<double?> getBatteryLevel() async {
    final version = await methodChannel.invokeMethod<double>('getBatteryLevel');
    return version;
  }

  Future<List<UsedApp>> get apps async {
    final List<dynamic>? usedApps = await methodChannel.invokeListMethod<dynamic>('getUsedApps');
    return usedApps?.map(UsedApp.fromJson).toList() ?? [];
  }

  @override
  Future<String> setAppTimeLimit(String appId, Duration duration) async {
    try {
      final String? result =
      await methodChannel.invokeMethod('setAppTimeLimit', {
        'id': appId,
        'durationInMinutes': duration.inMinutes,
      });
      return result ?? 'Could not set timer.';
    } on PlatformException catch (ex) {
      return ex.message ?? 'Unexpected error';
    }
  }
}
