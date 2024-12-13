import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixpanelManager {
  static Mixpanel? _mixpanel;

  static Future<Mixpanel> init() async {
    _mixpanel ??= await Mixpanel.init(
      "2e6732996810e8d5e66c8eb94f5ce1ab",
      optOutTrackingDefault: true,
      trackAutomaticEvents: true,
    );
    return _mixpanel!;
  }
}
