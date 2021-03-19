import 'package:flutter/material.dart';
import '../models/models.dart';

class Configurations {
  static final Configurations _instance =
      new Configurations._privateConstructor();

  static final bool devBuild = true;
  static final bool debugBanner = false;

  Configurations._privateConstructor() {
    debugPrint('Using Config');
  }

  factory Configurations() => _instance;

  final bool _bypassbackend = true;

  final String _appTitle = "useronboarding";
  final String _appVersion = "0.0.1";
  final String _author = 'Deakin Launchpad';
  final String _appCopyRight = "Deakin Launchpad 2021";

  final String _backendUrl = "http://localhost:8041";

  final UserLoginDetails _devDetails = new UserLoginDetails(
    username: "developer@dev.dev",
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

  UserLoginDetails get getDevDetails => _devDetails;

  String get devAccessToken => _devAccessToken;

  String get author => _author;
}
