import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wear/wear_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // ignore: unused_local_variable
  MethodChannelWear platform = MethodChannelWear();
  const MethodChannel channel = MethodChannel('wear');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });
}
