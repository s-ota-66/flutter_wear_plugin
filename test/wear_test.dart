import 'package:flutter_test/flutter_test.dart';
import 'package:wear/wear_platform_interface.dart';
import 'package:wear/wear_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWearPlatform with MockPlatformInterfaceMixin implements WearPlatform {
  @override
  Future<String> getShape() {
    // TODO: implement getShape
    throw UnimplementedError();
  }

  @override
  Future<bool> isAmbient() {
    // TODO: implement isAmbient
    throw UnimplementedError();
  }

  @override
  Future<void> setAmbientOffloadEnabled(bool enabled) {
    // TODO: implement setAmbientOffloadEnabled
    throw UnimplementedError();
  }

  @override
  Future<void> setAutoResumeEnabled(bool enabled) {
    // TODO: implement setAutoResumeEnabled
    throw UnimplementedError();
  }

  @override
  void registerAmbientCallback(AmbientCallback callback) {
    // TODO: implement registerAmbientCallback
  }

  @override
  void unregisterAmbientCallback(AmbientCallback callback) {
    // TODO: implement unregisterAmbientCallback
  }
}

void main() {
  final WearPlatform initialPlatform = WearPlatform.instance;

  test('$MethodChannelWear is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWear>());
  });
}
