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
  bool isExpert = false;
  int money = 0;
  List? favList = [];
  List li = [];

  String url = 'http://192.168.1.102:8000';

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
      print(response.body);
    } else {
      //print(response.body);
    }
    isLoading = false;
    await login(
        LogInModel(email: singUpModel.email, password: singUpModel.password));
    return response;
  }

  Future registerExpert(ExpertModels expert) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    notifyListeners();
    // http.Response response = await http.post(
    //   Uri.parse('$url/api/add-expert'),
    //   headers: {
    //     'Accept': 'application/json',
    //   },
    //   body: {
    //     "mobile": expert.mobile,
    //     "address": expert.address,
    //     "brief": expert.brief,
    //     "session_period": expert.sessionPeriod,
    //     "categoriesIds": jsonEncode(expert.consId),
    //     "available": jsonEncode(expert.time),
    //     'session_price': expert.money,
    //     "token": token,
    //     //'image' : base64Encode(expert.pickedImage.readAsBytesSync()),
    //   },
    // );

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '$url/api/add-expert',
        ));
    request.fields.addAll({
      "mobile": expert.mobile,
      "address": expert.address,
      "brief": expert.brief,
      "session_period": expert.sessionPeriod,
      "categoriesIds": jsonEncode(expert.consId),
      "available": jsonEncode(expert.time),
      'session_price': expert.money,
      "token": token,
    });
    request.files.add(await http.MultipartFile.fromPath('image',expert.pickedImage.path));
    request.headers.addAll(
      {
        'Accept': 'application/json',
      },
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      isBack = true;
      isExpert = true;
      print(response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    isLoading = false;
    //return response;
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
    Map<String, dynamic> map = jsonDecode(response.body);
    if (response.statusCode == 200) {
      isBack = true;
      setData(true);
      token = map['access_token'];
      money = map['user']['money'];
      isExpert = map['isExpert'];
      print(money);
      print(response.body);
    } else {
      print(response.body);
    }
    isLoading = false;
    notifyListeners();
    return response;
  }

  Future setData(bool t) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime? expirationDate =
        token.isNotEmpty ? JwtDecoder.getExpirationDate(token) : null;
    if (t && expirationDate != null && expirationDate.isAfter(DateTime.now())) {
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
        'token': token,
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
    } else {
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
        'token': token,
        'language': isEn ? '' : 'ar',
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      print(response.body);
    } else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }

  Future<http.Response> bookingApp(
      int expertId, String date, String time) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response response = await http.post(
      Uri.parse('$url/api/expert/$expertId/book'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token': token,
        'date': date,
        'time': time,
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      print(response.body);
    } else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }

  Future<http.Response> showExpert(int categoryId) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response response = await http.post(
      Uri.parse('$url/api/$categoryId/experts'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      print(response.body);
    } else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }

  Future<http.Response> showExpertDetails(int id) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response res = await http.post(
      Uri.parse('$url/api/expert/$id'),
      headers: {
        'Accept': 'application/json',
      },
      body: {'token': token},
    );
    if (res.statusCode == 200) {
      isBack = true;
      //print(res.body);
    } else {
      print(res.body);
    }
    isLoading = false;
    return res;
  }

  Future<http.Response> showApp() async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response response = await http.post(
      Uri.parse('$url/api/profile'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      var map = jsonDecode(response.body);
     // money = map["userMoney"];
      isBack = true;
      print(response.body);
    } else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }

  Future<http.Response> delApp(int appointmentId) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response response = await http.delete(
      Uri.parse('$url/api/$appointmentId/delete'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      print(response.body);
    } else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }

  Future<http.Response> showFav() async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response response = await http.post(
      Uri.parse('$url/api/my-favorite'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      favList = jsonDecode(response.body)['favorite'];
      print(favList);
      print(response.body);
    } else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }

  Future<http.Response> addFav(int expertId) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response response = await http.post(
      Uri.parse('$url/api/$expertId/add-to-fav'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      print(response.body);
      showFav();
    } else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }

  Future<http.Response> delFav(int expertId) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response response = await http.delete(
      Uri.parse('$url/api/$expertId/delete/fav'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      print(response.body);
      showFav();
    } else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }

  bool isMealFavorites(int id) {
    notifyListeners();
    return favList!.any((expert) {
      print(id);
      print(expert['id']);
      return id == expert['id'];
    });
  }

  Future<http.Response> rate(int expertId, double rate) async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response response = await http.post(
      Uri.parse('$url/api/$expertId/rate'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token': token,
        'rate': rate.toString(),
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      print(response.body);
      showFav();
    } else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }

  Future<http.Response> search() async {
    isLoading = false;
    isBack = false;
    isLoading = true;
    http.Response response = await http.post(
      Uri.parse('$url/api/getExpert'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'token': token,
      },
    );
    if (response.statusCode == 200) {
      isBack = true;
      print(response.body);
    } else {
      print(response.body);
    }
    isLoading = false;
    return response;
  }
}
