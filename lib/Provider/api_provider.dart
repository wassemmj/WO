import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/sing_up_model.dart';
import '../Models/log_in_model.dart';

class ApiProvider with ChangeNotifier {
  bool isLoading = false;
  bool isBack = false;
  String token = '';

  String url = 'http://192.168.1.101:8000';

  Future<http.Response> register(SingUpModel singUpModel) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    notifyListeners();
    http.Response response = await http.post(
        Uri.parse('$url/api/auth/register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(singUpModel.toJson()),
      );
    if (response.statusCode == 201) {
      isBack = true;
      //print(response.body);
    }else {
      print(response.body);
    }
    isLoading = false;
    await login(LogInModel(email: singUpModel.email, password: singUpModel.password));
    return response;
  }

  Future<http.Response> login(LogInModel logInModel) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    notifyListeners();
    http.Response response = await http.post(
      Uri.parse('$url/api/auth/login'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(logInModel.toJson()),
    );
    Map<String,dynamic> map = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isBack = true;
      setData(true);
      token = map['access_token'];
      //print(response.body);
    }else {
      print(response.body);
    }
    isLoading = false;
    notifyListeners();
    return response;
  }

  Future setData(bool t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('login', t);
  }

  Future<http.Response> logOut() async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    notifyListeners();
    http.Response response = await http.post(
      Uri.parse('$url/api/auth/logout'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token' : token,
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      setData(false);
      //print(response.body);
    }else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }
}
