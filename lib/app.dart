import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/userDataProvider.dart';
import './configurations/configurations.dart';
import './routes/index.dart';
import './theme/theme.dart';

import './screens/home.dart';
import './screens/login.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserDataProvider(),
        ),
      ],
      child: Consumer<UserDataProvider>(
        builder: (_, data, __) => MaterialApp(
          home: data.loginStatus
              ? Home()
              : FutureBuilder(
                  future: data.accessTokenLogin(),
                  builder: (_, result) =>
                      result.connectionState == ConnectionState.waiting
                          ? Scaffold(
                              body: Text('Loading..'),
                            )
                          : Login(),
                ),
          title: Configurations().appTitle,
          theme: applicationTheme,
          routes: Routes().base,
        ),
      ),
    );
  }
}