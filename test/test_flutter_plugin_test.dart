import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_plugin/test_flutter_plugin.dart';
import 'package:test_flutter_plugin/test_flutter_plugin_platform_interface.dart';
import 'package:test_flutter_plugin/test_flutter_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTestFlutterPluginPlatform
    with MockPlatformInterfaceMixin
    implements TestFlutterPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TestFlutterPluginPlatform initialPlatform = TestFlutterPluginPlatform.instance;

  test('$MethodChannelTestFlutterPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTestFlutterPlugin>());
  });

  test('getPlatformVersion', () async {
    TestFlutterPlugin testFlutterPlugin = TestFlutterPlugin();
    MockTestFlutterPluginPlatform fakePlatform = MockTestFlutterPluginPlatform();
    TestFlutterPluginPlatform.instance = fakePlatform;

    expect(await testFlutterPlugin.getPlatformVersion(), '42');
  });
}
