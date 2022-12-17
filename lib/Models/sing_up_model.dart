class SingUpModel {
  String name;
  String email;
  String password;
  String confirmedPassword;

  SingUpModel({required this.name, required this.email, required this.password, required this.confirmedPassword});

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic> {};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = confirmedPassword;
    return data;
  }
}