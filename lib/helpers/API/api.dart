import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../models/modelHelpers.dart';
import '../../models/models.dart';
import './dioInstance.dart';

class API {
  static final API api = API._privateConstructor();
  final Dio _dioinstance = DioInstance().instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  API._privateConstructor() {
    print("All APIs initialized.");
  }

  factory API() {
    return api;
  }

  DIOResponseBody errorHelper(error) {
    if (error == null)
      return DIOResponseBody(success: false, data: 'Network Error');
    if (error.response == null)
      return DIOResponseBody(success: false, data: "Network Error");
    if (error.response == null)
      return DIOResponseBody(
          success: false, data: 'Connection to Backend Failed');
    if (error.response.data["message"] != null)
      return DIOResponseBody(
          success: false, data: error.response.data["message"]);
    return DIOResponseBody(success: false, data: "Oops! Something went wrong!");
  }

  Future<DIOResponseBody> userLogin(UserLoginDetails details) async {
    return _firebaseAuth
        .signInWithEmailAndPassword(
            email: details.username, password: details.password)
        .then((response) async {
      IdTokenResult token = await response.user.getIdToken();
      return DIOResponseBody(success: true, data: token.token);
    }).catchError((error) {
      return DIOResponseBody(
          success: false, data: (error as PlatformException).message);
    });
  }

  Future<bool> accessTokenLogin(String accessToken) async {
    return _firebaseAuth.currentUser().then((user) => user != null);
  }

  Future<DIOResponseBody> registerUser(userDetails) async {
    print(userDetails);
    return _firebaseAuth
        .createUserWithEmailAndPassword(
            email: userDetails["emailId"], password: "123456")
        .then((response) {
      return DIOResponseBody(success: true, data: response.user);
    }).catchError((error) {
      print(error);
      return DIOResponseBody(success: false, data: error.message);
    });
  }
}
