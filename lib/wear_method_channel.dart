import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wear_platform_interface.dart';

/// An implementation of [WearPlatform] that uses method channels.
class MethodChannelWear extends WearPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel;

  MethodChannelWear() : methodChannel = const MethodChannel('wear') {
    methodChannel.setMethodCallHandler(_onMethodCallHandler);
  }

  Future<dynamic> _onMethodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onEnterAmbient':
        final args = (call.arguments as Map).cast<String, bool>();
        final details =
            AmbientDetails(args['burnInProtection']!, args['lowBitAmbient']!);
        _notifyAmbientCallbacks((callback) => callback.onEnterAmbient(details));
        break;
      case 'onExitAmbient':
        _notifyAmbientCallbacks((callback) => callback.onExitAmbient());
        break;
      case 'onUpdateAmbient':
        _notifyAmbientCallbacks((callback) => callback.onUpdateAmbient());
        break;
      case 'onInvalidateAmbientOffload':
        _notifyAmbientCallbacks(
            (callback) => callback.onInvalidateAmbientOffload());
        break;
    }
  }

  void _notifyAmbientCallbacks(Function(AmbientCallback callback) fn) {
    final callbacks = List<AmbientCallback>.from(_ambientCallbacks);
    for (final callback in callbacks) {
      try {
        fn(callback);
      } catch (e, st) {
        debugPrint('Failed callback: $callback\n$e\n$st');
      }
    }
  }

  final _ambientCallbacks = <AmbientCallback>[];

  /// Register callback for ambient notifications
  @override
  void registerAmbientCallback(AmbientCallback callback) {
    _ambientCallbacks.add(callback);
  }

  /// Unregister callback for ambient notifications
  @override
  void unregisterAmbientCallback(AmbientCallback callback) {
    _ambientCallbacks.remove(callback);
  }

  /// Fetches the shape of the watch face
  @override
  Future<String> getShape() async {
    try {
      return (await methodChannel.invokeMethod<String>('getShape'))!;
    } on PlatformException catch (e, st) {
      // Default to round
      debugPrint('Error calling getShape: $e\n$st');
      return 'round';
    }
  }

  /// Tells the application if we are currently in ambient mode
  @override
  Future<bool> isAmbient() async {
    try {
      return (await methodChannel.invokeMethod<bool>('isAmbient'))!;
    } on PlatformException catch (e, st) {
      debugPrint('Error calling isAmbient: $e\n$st');
      return false;
    }
  }

  /// Sets whether this activity's task should be moved to the front when
  /// the system exits ambient mode.
  ///
  /// If true, the activity's task may be moved to the front if it was the
  /// last activity to be running when ambient started, depending on how
  /// much time the system spent in ambient mode.
  ///
  @override
  Future<void> setAutoResumeEnabled(bool enabled) async {
    try {
      await methodChannel.invokeMethod<String>(
        'setAutoResumeEnabled',
        {'enabled': enabled},
      );
    } on PlatformException catch (e, st) {
      debugPrint('Error calling setAutoResumeEnabled: $e\n$st');
      rethrow;
    }
  }

  /// Sets whether this activity is currently in a state that supports ambient offload mode.
  @override
  Future<void> setAmbientOffloadEnabled(bool enabled) async {
    try {
      await methodChannel.invokeMethod<String>(
        'setAmbientOffloadEnabled',
        {'enabled': enabled},
      );
    } on PlatformException catch (e, st) {
      debugPrint('Error calling setAmbientOffloadEnabled: $e\n$st');
      rethrow;
    }
  }
}
