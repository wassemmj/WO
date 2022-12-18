import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  bool isEn = true;

  Map<String, Object> textAr = {
    "drawer_item1": "الحجوزات",
    "drawer_item2": "تسجيل الخروج",
    "drawer_item3": "المال",
    "drawer_switch_title": "اختر لغتك الفضلةة",
    "drawer_switch_item1": "الانكليزية",
    "drawer_switch_item2": "العربية",
    'splash_screen_item1': 'جاري التحميل...',
    "constructions": "الاستشارات",
    "favorites": "المفضلة",
    'favorites_item1': 'ليس هناك اي شيء مفضل بعد!',
    'reservation' : 'الحجوزات',
    'login_title' : 'تسجيل الدخول',
    'login_tf_t1': 'البريد الالكتروني',
    'login_tf_h1': 'ادخل بريدك الالكتروني',
    'login_tf_v11': 'البريد الالكتروني اجباري',
    'login_tf_v12': 'بريد الكتروني غير صالح',
    'login_tf_t2': 'كلمةالمرور',
    'login_tf_h2': 'ادخل كلمة المرور',
    'login_tf_v21': 'كلمة المرور مطلوبة',
    'login_tf_v22': 'كلمة السر قصيرة',
    'login_item_1': 'لست عضو؟',
    'login_item_2': 'سجل الان',
    'sing_up_title': 'تسجيل',
    'sing_up_next' : 'تابع',
    'sing_up_tf_t1' : 'اسم المستخدم',
    'sing_up_tf_h1' : 'ادخل الاسم',
    'sing_up_tf_v1' : 'الاسم ضروري',
    'sing_up_tf_t2' : 'البريد الالكتروني',
    'sing_up_tf_h2' : 'ادخل البريد الالكتروني',
    'sing_up_tf_t3' : 'كلمة السر',
    'sing_up_tf_h3' : 'ادخل كلمة السر',
    'sing_up_tf_t4' :  "تاكيد كلمة السر",
    'sing_up_tf_h4' : 'اكد كلمة السر',
    'sing_up_tf_v41' : 'كلمات السر غير متوافقة',
    'sing_up_item1' : 'عندي حساب؟',
    'ex_item1': 'اكمل حسابك الشخصي',
    'ex_item2_h' : 'ادخل رقم هاتفك',
    'ex_item2_l' : 'رقم الهاتف',
    'ex_item3_h' : 'ادخل عنوانك',
    'ex_item3_l' : 'العنوان',
  };

  Map<String, Object> textEn = {
    "drawer_item1": "Reservation",
    "drawer_item2": "Log Out",
    "drawer_item3": "Money ",
    "drawer_switch_title": "Choose your language.",
    "drawer_switch_item1": "English",
    "drawer_switch_item2": "Arabic",
    'splash_screen_item1': 'Loading...',
    "constructions": "Constructions",
    "favorites": "Favorites",
    'favorites_item1': 'You have no favorites yet!',
    'reservation' : 'Reservation',
    'login_title' : 'Log In',
    'login_tf_t1': 'Email',
    'login_tf_h1': 'Enter Email',
    'login_tf_v11': 'Email is Required',
    'login_tf_v12': 'Not a Valid Email',
    'login_tf_t2': 'Password',
    'login_tf_h2': 'Enter Password',
    'login_tf_v21': 'Password is Required',
    'login_tf_v22': 'Short Password',
    'login_item_1': 'Not a member?',
    'login_item_2': 'Register Now',
    'sing_up_title': 'Sign Up',
    'sing_up_next' : 'Continue',
    'sing_up_tf_t1' : 'UserName',
    'sing_up_tf_h1' : 'Enter Your Name',
    'sing_up_tf_v1' : 'Name is Required',
    'sing_up_tf_t2' : 'Email',
    'sing_up_tf_h2' : 'Enter Email',
    'sing_up_tf_t3' : 'Password',
    'sing_up_tf_h3' : 'Enter Your Password',
    'sing_up_tf_t4' : 'Confirm Password',
    'sing_up_tf_h4' : 'Confirm Your Password',
    'sing_up_tf_v41' : 'Passwords don\'t match',
    'sing_up_item1' : 'already have an account?',
    'ex_item1' : 'Complete Your Profile',
    'ex_item2_h' : 'Enter Phone Number',
    'ex_item2_l' : 'Phone Number',
    'ex_item3_h' : 'Enter Address',
    'ex_item3_l' : 'Address',
  };

  changeLan(bool lan) async{
    isEn = lan;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isEn", isEn);
  }

  getLan() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isEn = prefs.getBool("isEn")?? true;
    notifyListeners();
  }

  Object? getText(String txt) {
    if (isEn == true) return textEn[txt];
    return textAr[txt];
  }
}