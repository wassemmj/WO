import 'dart:io';

class ExpertModels {
  ExpertModels({
    required this.mobile,
    required this.address,
    required this.brief,
    required this.sessionPeriod,
    required this.time,
    required this.consId,
    required this.money,
    required this.pickedImage,
  });

  String mobile;
  String address;
  String money;
  String brief;
  String sessionPeriod;
  List consId;
  List<Map<String, String>> time;
  File pickedImage;
}
