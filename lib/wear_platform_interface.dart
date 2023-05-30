import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wear_method_channel.dart';

abstract class WearPlatform extends PlatformInterface {
  /// Constructs a WearPlatform.
  WearPlatform() : super(token: _token);

  static final Object _token = Object();

  static WearPlatform _instance = MethodChannelWear();

  /// The default instance of [WearPlatform] to use.
  ///
  /// Defaults to [MethodChannelWear].
  static WearPlatform get instance => _instance;

  /// Register callback for ambient notifications
  void registerAmbientCallback(AmbientCallback callback) {
    throw UnimplementedError(
        'registerAmbientCallback() has not been implemented.');
  }

  /// Unregister callback for ambient notifications
  void unregisterAmbientCallback(AmbientCallback callback) {
    throw UnimplementedError(
        'unregisterAmbientCallback() has not been implemented.');
  }

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WearPlatform] when
  /// they register themselves.
  static set instance(WearPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Fetches the shape of the watch face
  Future<String> getShape() async {
    throw UnimplementedError('getShape() has not been implemented.');
  }

  /// Tells the application if we are currently in ambient mode
  Future<bool> isAmbient() async {
    throw UnimplementedError('isAmbient() has not been implemented.');
  }

  /// Sets whether this activity's task should be moved to the front when
  /// the system exits ambient mode.
  ///
  /// If true, the activity's task may be moved to the front if it was the
  /// last activity to be running when ambient started, depending on how
  /// much time the system spent in ambient mode.
  ///
  Future<void> setAutoResumeEnabled(bool enabled) async {
    throw UnimplementedError(
        'setAutoResumeEnabled() has not been implemented.');
  }

  /// Sets whether this activity is currently in a state that supports ambient offload mode.
  Future<void> setAmbientOffloadEnabled(bool enabled) async {
    throw UnimplementedError(
        'setAmbientOffloadEnabled() has not been implemented.');
  }
}

/// Provides details of current ambient mode configuration.
class AmbientDetails {
  const AmbientDetails(this.burnInProtection, this.lowBitAmbient);

  /// Used to indicate whether burn-in protection is required.
  ///
  /// When this property is set to true, views must be shifted around
  /// periodically in ambient mode. To ensure that content isn't
  /// shifted off the screen, avoid placing content within 10 pixels
  /// of the edge of the screen. Activities should also avoid solid
  /// white areas to prevent pixel burn-in. Both of these
  /// requirements only apply in ambient mode, and only when
  /// this property is set to true.
  final bool burnInProtection;

  /// Used to indicate whether the device has low-bit ambient mode.
  ///
  /// When this property is set to true, the screen supports fewer bits
  /// for each color in ambient mode. In this case, activities should
  /// disable anti-aliasing in ambient mode.
  final bool lowBitAmbient;
}

/// Callback to receive ambient mode state changes.
mixin class AmbientCallback {
  /// Called when an activity is entering ambient mode.
  void onEnterAmbient(AmbientDetails ambientDetails) {}

  /// Called when an activity should exit ambient mode.
  void onExitAmbient() {}

  /// Called when the system is updating the display for ambient mode.
  void onUpdateAmbient() {}

  /// Called to inform an activity that whatever decomposition it has sent to
  /// Sidekick is no longer valid and should be re-sent before enabling ambient offload.
  void onInvalidateAmbientOffload() {}
}
