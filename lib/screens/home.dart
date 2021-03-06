import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../providers/providers.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User OnBoarding'),
          actions: <Widget>[
            GestureDetector(
                onTap: () {},
                child: Consumer<UserDataProvider>(
                    builder: (_, data, __) => FlatButton(
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            data.logout();
                            Navigator.pushReplacementNamed(context, '/');
                          },
                        )))
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Consumer<UserDataProvider>(
            builder: (_, data, __) => Center(
              child: Column(
                children: <Widget>[
                  Flexible(
                      child: Text(
                    'accessToken: ' + data.accessToken,
                    style: Theme.of(context).textTheme.bodyText1,
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
