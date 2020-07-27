import 'package:flutter/material.dart';
import '../models/models.dart';

class Configurations {
  static final bool devBuild = true;
  static final bool debugBanner = false;

  final bool _bypassbackend = false;

  final String _appTitle = "useronboarding";
  final String _appVersion = "0.0.1";
  final String _appCopyRight = "Sanchit Dang 2020";

  final String _backendUrl = "http://localhost:8041";

  final UserLoginDetails _devDetails = new UserLoginDetails(
    username: "user@test.com",
    password: "secretpassword",
  );
  final String _devAccessToken = "";

  LayoutConfig _layoutConfig =
      LayoutConfig(primaryColor: Colors.indigo, secondaryColor: Colors.yellow);

  final List<SidebarItem> sideBarItems = [];

  LayoutConfig get layoutConfig => _layoutConfig;

  String get backendUrl => _backendUrl;

  String get appTitle => _appTitle;

  bool get bypassBackend => _bypassbackend;

  String get appVersion => _appVersion;

  String get appCP => _appCopyRight;

  UserLoginDetails get devDetails => _devDetails;

  String get devAccessToken => _devAccessToken;
}
