import 'package:flutter/material.dart';

abstract class NavigationService {
  Future<T?> navigateTo<T>(String routeName, {Object? arguments});
  void pop<T>([T? result]);
  GlobalKey<NavigatorState> get navigationKey;
}

class NavigationServiceImpl implements NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  @override
  Future<T?> navigateTo<T>(String routeName, {Object? arguments}) {
    return _navigationKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  @override
  void pop<T>([T? result]) {
    return _navigationKey.currentState!.pop(result);
  }
}
