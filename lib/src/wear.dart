import 'package:wear/wear_platform_interface.dart';

class Wear {
  factory Wear() => instance;

  static final instance = Wear._();

  Wear._();

  /// Register callback for ambient notifications
  void registerAmbientCallback(AmbientCallback callback) {
    WearPlatform.instance.registerAmbientCallback(callback);
  }

  /// Unregister callback for ambient notifications
  void unregisterAmbientCallback(AmbientCallback callback) {
    WearPlatform.instance.unregisterAmbientCallback(callback);
  }

  /// Fetches the shape of the watch face
  Future<String> getShape() async {
    return WearPlatform.instance.getShape();
  }

  /// Tells the application if we are currently in ambient mode
  Future<bool> isAmbient() async {
    return WearPlatform.instance.isAmbient();
  }

  /// Sets whether this activity's task should be moved to the front when
  /// the system exits ambient mode.
  ///
  /// If true, the activity's task may be moved to the front if it was the
  /// last activity to be running when ambient started, depending on how
  /// much time the system spent in ambient mode.
  ///
  Future<void> setAutoResumeEnabled(bool enabled) async {
    WearPlatform.instance.setAutoResumeEnabled(enabled);
  }

  /// Sets whether this activity is currently in a state that supports ambient offload mode.
  Future<void> setAmbientOffloadEnabled(bool enabled) async {
    WearPlatform.instance.setAmbientOffloadEnabled(enabled);
  }
}
