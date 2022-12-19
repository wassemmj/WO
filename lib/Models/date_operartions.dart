import 'package:intl/intl.dart';

class DateOperartions{
  int _month=DateTime.now().month;
  int _year=DateTime.now().year;

  String getDateNAme({int index=1}){
    var _daynameWeek=DateFormat.EEEE().format(DateTime(_year, _month, index));
    return _daynameWeek;
  }

  int getMonthdays(){
    if(_month==1){
      return 31;
    }
    else if(_month==2){
      return 28;
    }
    else if(_month==3){
      return 31;
    }
    else if(_month==4){
      return 30;
    }
    else if(_month==5){
      return 31;
    }
    else if(_month==6){
      return 30;
    }
    else if(_month==7){
      return 31;
    }
    else if(_month==8){
      return 31;
    }
    else if(_month==9){
      return 30;
    }
    else if(_month==10){
      return 31;
    }
    else if(_month==11){
      return 30;
    }
    else if(_month==12){
      return 31;
    }
    else {
      return 1;
    }
  }

  String getMonthdaysDaysName(){
    if(_month==1){
      return "Jan";
    }
    else if(_month==2){
      return "Feb";
    }
    else if(_month==3){
      return "Mar";
    }
    else if(_month==4){
      return "Apr";
    }
    else if(_month==5){
      return "May";
    }
    else if(_month==6){
      return "Jun";
    }
    else if(_month==7){
      return "Jul";
    }
    else if(_month==8){
      return "Aug";
    }
    else if(_month==9){
      return "Sep";
    }
    else if(_month==10){
      return "Oct";
    }
    else if(_month==11){
      return "Nov";
    }
    else if(_month==12){
      return "Dec";
    }
    else {
      return 'ff';
    }
  }

  int getCurrentDate(){
    return DateTime.now().day;
  }


}