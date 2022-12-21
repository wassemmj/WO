import 'dart:convert';

import 'package:cons_app/Models/expert_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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

  Future<http.Response> registerExpert(ExpertModels expert) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    notifyListeners();
    http.Response response = await http.post(
      Uri.parse('$url/api/add-expert'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        "mobile": expert.mobile,
        "address": expert.address,
        "brief": expert.brief,
        "session_period": '02:30',
        "categoriesIds": expert.consId.toString(),
        "available": expert.time.toString(),
        "token":token,
        'image' : expert.pickedImage
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      print(response.body);
    }else {
      print(response.body);
    }
    isLoading = false;
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
    DateTime? expirationDate = token.isNotEmpty? JwtDecoder.getExpirationDate(token):null;
    if(t&&expirationDate!=null&&expirationDate.isAfter(DateTime.now())) {
      prefs.setBool('login', t);
    } else {
      prefs.setBool('login', false);
    }
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
    // Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    // print(decodedToken);
    // DateTime expirationDate = JwtDecoder.getExpirationDate(token);
    // print(expirationDate);
    if (response.statusCode == 200) {
      isBack = true;
      setData(false);
      print(response.body);
      token = '';
    }else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }

  Future<http.Response> category(bool isEn) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response response = await http.post(
      Uri.parse('$url/api/category'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token' : token,
        'language': isEn ? '':'ar',
      },
    );
    if(response.statusCode == 200) {
      isBack = true;
      print(response.body);
    }else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }
}
