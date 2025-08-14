import 'dart:async';
import 'package:flutter/foundation.dart';


class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _sub = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }
  late final StreamSubscription<void> _sub;
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}