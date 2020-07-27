import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configurations/configurations.dart';
import '../helpers/helpers.dart';
import '../providers/providers.dart';
import '../models/models.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _devModeSwitchValue = false;
  final _loginFormKey = GlobalKey<FormState>();
  final _passwordFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final UserLoginDetails loginValues = UserLoginDetails();
  final Configurations _config = new Configurations();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _changeDevModeValue(bool value) {
    setState(() {
      if (value) {
        _usernameController.text = _config.devDetails.username;
        _passwordController.text = _config.devDetails.password;
      } else {
        _usernameController.text = '';
        _passwordController.text = '';
      }
      _devModeSwitchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    void performLogin(Function assignToken) async {
      if (_loginFormKey.currentState.validate()) {
        _loginFormKey.currentState.save();
        DIOResponseBody loginCheck = await API().userLogin(loginValues);
        if (loginCheck.success) {
          assignToken(loginCheck.data);
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(loginCheck.data),
          ));
        }
      }
    }

    return Form(
      key: _loginFormKey,
      child: ListView(
        padding: EdgeInsets.all(20),
        shrinkWrap: true,
        children: <Widget>[
          if (Configurations.devBuild)
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text('DevMode'),
                    Switch(
                      value: _devModeSwitchValue,
                      onChanged: (newValue) {
                        _changeDevModeValue(newValue);
                      },
                    ),
                  ],
                )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              focusNode: _usernameFocusNode,
              controller: _usernameController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              },
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'JohnDoe@example.com',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {
                loginValues.username = value;
              },
              validator: (value) {
                if (_devModeSwitchValue) return null;
                if (value.isEmpty) return 'Please Enter the Email';
                if (!TextHelper().validateEmail(value))
                  return 'Enter Valid Email';
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              focusNode: _passwordFocusNode,
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'mysecretpassword',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              obscureText: true,
              onSaved: (value) {
                loginValues.password = value;
              },
              validator: (value) {
                if (_devModeSwitchValue) return null;

                if (value.isEmpty) {
                  return 'Please Enter the password';
                }
                return null;
              },
            ),
          ),
          Consumer<UserDataProvider>(
              builder: (_, data, __) => RaisedButton(
                    onPressed: () {
                      if (_config.bypassBackend) {
                        data.assignAccessToken(_config.devAccessToken);
                        Navigator.of(context).pushReplacementNamed('/home');
                        return;
                      }
                      performLogin(data.assignAccessToken);
                    },
                    child: Text('Login'),
                    color: Theme.of(context).accentColor,
                  )),
          RaisedButton(
            child: Text('Sign Up'),
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
          )
        ],
      ),
    );
  }
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.purple,
              Colors.red,
              Colors.orange,
            ])),
        child: SafeArea(
          bottom: true,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Flutter User Onboarding',
                  style: TextStyle(
                      fontSize: 60,
                      fontFamily: 'pricedown',
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(2, 2),
                            blurRadius: 15)
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 50, right: 50, top: 20),
                color: Colors.white,
                elevation: 50,
                child: LoginForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
