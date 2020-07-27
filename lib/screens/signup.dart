import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../helpers/API/api.dart';
import '../models/modelHelpers.dart';

class SignupTextFeild extends StatefulWidget {
  final String label, hint;
  final TextInputType type;
  final TextInputAction action;
  final Function validator, onSaved, onSubmit;
  final FocusNode focusNode;
  final bool isPassword;
  final TextEditingController controller;
  final List<TextInputFormatter> formatter;
  SignupTextFeild(
      {this.hint,
      this.label,
      this.action,
      this.onSubmit,
      this.onSaved,
      this.type,
      this.validator,
      this.focusNode,
      this.isPassword,
      this.controller,
      this.formatter});

  @override
  _SignupTextFeildState createState() => _SignupTextFeildState();
}

class _SignupTextFeildState extends State<SignupTextFeild> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        textInputAction: widget.action,
        inputFormatters: widget.formatter,
        onFieldSubmitted: widget.onSubmit,
        obscureText: widget.isPassword == null ? false : passwordVisible,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          suffixIcon: widget.isPassword == null
              ? null
              : IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
          labelStyle:
              TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
          focusColor: Colors.blueAccent,
          hoverColor: Colors.blueAccent,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(color: Colors.blueAccent, width: 2.3),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
          ),
        ),
        keyboardType: widget.type,
        onSaved: widget.onSaved,
        validator: widget.validator,
      ),
    );
  }
}

class SignUpValues {
  String firstname, lastname, email, password, number;

  SignUpValues(
      {this.email, this.firstname, this.lastname, this.password, this.number});
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _signUpFormKey = GlobalKey<FormState>();
  final SignUpValues signUpValues = SignUpValues();
  final TextEditingController _passwordController = TextEditingController();
  String confirmPasswordString = "";

  final lastname = FocusNode();
  final email = FocusNode();
  final password = FocusNode();
  final cpassword = FocusNode();
  final number = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signUpFormKey,
      child: ListView(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        children: <Widget>[
          SignupTextFeild(
            label: 'First Name',
            hint: 'John',
            action: TextInputAction.next,
            onSaved: (value) {
              signUpValues.firstname = value;
            },
            onSubmit: (_) {
              FocusScope.of(context).requestFocus(lastname);
            },
            type: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the first name';
              }
              return null;
            },
          ),
          SignupTextFeild(
            focusNode: lastname,
            label: 'Last Name',
            hint: 'Doe',
            action: TextInputAction.next,
            type: TextInputType.text,
            onSaved: (value) {
              signUpValues.lastname = value;
            },
            onSubmit: (_) {
              FocusScope.of(context).requestFocus(email);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the last name';
              }
              return null;
            },
          ),
          SignupTextFeild(
            focusNode: email,
            label: 'Email',
            hint: 'johndoe@shaktiman.com',
            action: TextInputAction.next,
            type: TextInputType.text,
            onSaved: (value) {
              signUpValues.email = value;
            },
            onSubmit: (_) {
              FocusScope.of(context).requestFocus(password);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the email';
              }
              Pattern emailPattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = new RegExp(emailPattern);
              if (!regex.hasMatch(value)) return 'Enter Valid Email';
              return null;
            },
          ),
          SignupTextFeild(
            controller: _passwordController,
            focusNode: password,
            label: 'Password',
            hint: 'secretpassword',
            isPassword: true,
            action: TextInputAction.next,
            type: TextInputType.text,
            onSaved: (value) {
              signUpValues.password = value;
            },
            onSubmit: (_) {
              FocusScope.of(context).requestFocus(cpassword);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the password';
              }
              return null;
            },
          ),
          SignupTextFeild(
            focusNode: cpassword,
            label: 'Confirm Password',
            hint: 'secretpassword',
            isPassword: true,
            action: TextInputAction.next,
            type: TextInputType.text,
            onSaved: (value) {
              confirmPasswordString = value;
            },
            onSubmit: (_) {
              FocusScope.of(context).requestFocus(number);
            },
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the confirmation password';
              }
              if (value != _passwordController.text) {
                return "Passwords don\'t match";
              }
              return null;
            },
          ),
          SignupTextFeild(
            focusNode: number,
            label: 'Number',
            hint: '412345678',
            action: TextInputAction.done,
            type: TextInputType.number,
            onSaved: (value) {
              print(value);
              signUpValues.number = value;
            },
            onSubmit: (_) {},
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the number';
              }
              return null;
            },
          ),
          RaisedButton(
            child: Text('SignUp'),
            onPressed: () async {
              if (_signUpFormKey.currentState.validate()) {
                _signUpFormKey.currentState.save();
                DIOResponseBody response = await API().registerUser({
                  "firstName": signUpValues.firstname.toString(),
                  "lastName": signUpValues.lastname.toString(),
                  "emailId": signUpValues.email.toString(),
                  "phoneNumber": signUpValues.number.toString(),
                  "countryCode": "+61",
                  "password": signUpValues.password
                });
                if (response.success)
                  return Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('User Registered'),
                  ));
                else
                  return Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(response.data),
                  ));
              }
              return null;
            },
          ),
          RaisedButton(
            child: Text('Back'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}

class SignUp extends StatelessWidget {
  static String route = '/signup';
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
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                color: Colors.white,
                elevation: 50,
                child: SignUpForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
