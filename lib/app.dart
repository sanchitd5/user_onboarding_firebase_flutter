import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/providers.dart';
import 'configurations/configurations.dart';
import './routes/routes.dart';
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
          debugShowCheckedModeBanner: Configurations.debugBanner,
          home: data.loginStatus
              ? Home()
              : FutureBuilder(
                  future: data.accessTokenLogin(),
                  builder: (_, result) {
                    if (result.connectionState == ConnectionState.waiting)
                      return Scaffold(
                        body: Text('Loading..'),
                      );
                    else if (result.data == true)
                      return Home();
                    else
                      return Login();
                  },
                ),
          title: Configurations().appTitle,
          theme: ApplicationTheme().getAppTheme,
          routes: Routes().base,
        ),
      ),
    );
  }
}
