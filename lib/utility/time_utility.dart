import 'package:flutter/material.dart';

class TimeUtility {
  static List daysWeek = ['Lunedì','Martedì','Mercoledì','Giovedì','Venerdì','Sabado','Domenica'];

  static String getHourMinute(TimeOfDay time) {
      final hour = time.hour.toString().padLeft(2, "0");
      final min = time.minute.toString().padLeft(2, "0");
     return "$hour:$min";
  }

  static String getDayWeekNow() {
    return daysWeek[DateTime.now().weekday-1];
  }

  static String getDayById(int index) {
    return daysWeek[index];
  }

  static int getIdDayWeekNow() {
    return DateTime.now().weekday-1;
  }

  static TimeOfDay getTimeOfDay(String time) {
      TimeOfDay startTime = TimeOfDay(hour:int.parse(time.split(":")[0]),minute: int.parse(time.split(":")[1]));
      return startTime;
  }

  static String addTotalTime(String time, String timeToAdd) {
     final int hour = int.parse(time.split(":")[0]);
     final int minute = int.parse(time.split(":")[1]);

     final int addHour = int.parse(timeToAdd.split(":")[0]);
     final int addMinute = int.parse(timeToAdd.split(":")[1]);

     final int newMinute = (minute + addMinute)>59?(60-(minute + addMinute))*-1:(minute + addMinute);
     final int newHour = hour + addHour + ((minute + addMinute)>59?1:0);

     return "$newHour:${newMinute.toString().padLeft(2, "0")}";
  }
  
  //Add to string time in format HH:MI new time in format HH:MI
  static String addTime(String time, String timeToAdd) {
     final TimeOfDay time0 = getTimeOfDay(time);
     final TimeOfDay newTime;
    
     final int hour = int.parse(timeToAdd.split(":")[0]);
     final int minute = int.parse(timeToAdd.split(":")[1]);

     final int newHour = time0.hour + hour + ((time0.minute + minute)>59?1:0);
     final int newMinute = (time0.minute + minute)>59?(60-(time0.minute + minute))*-1:(time0.minute + minute);

     if ( newHour > 23 ) {
        newTime = time0.replacing(hour: 23, minute: 59);
     } else {
        newTime = time0.replacing(hour: newHour, minute: newMinute);
     }

     return getHourMinute(newTime);
  }

  //Substract time in format HH:MI to another time in format HH:MI
  static String subTime(String time, String timeToSub) {

    //  print('SubTime from $time to $timeToSub');
     final TimeOfDay time0 = getTimeOfDay(time);
     final TimeOfDay newTime;
    
     final int hour = int.parse(timeToSub.split(":")[0]);
     final int minute = int.parse(timeToSub.split(":")[1]);

     final int newHour = time0.hour - hour - ((time0.minute - minute)<0?1:0);
     final int newMinute = (time0.minute - minute)<0?(60+time0.minute - minute):(time0.minute - minute);

     if ( newHour < 0 ) {
        newTime = time0.replacing(hour: 00, minute: 00);
     } else {
        newTime = time0.replacing(hour: newHour, minute: newMinute);
     }

     return getHourMinute(newTime);
  }


  // Return difference in minutes between time1 and time2 
  static int diffMinTime(String time1, String time2) {
     final int hour1 = int.parse(time1.split(":")[0]);
     final int minute1 = int.parse(time1.split(":")[1]);

     final int hour2 = int.parse(time2.split(":")[0]);
     final int minute2 = int.parse(time2.split(":")[1]);

     final int diffMin = (hour1*60 + minute1) - (hour2*60 + minute2);

     return diffMin;
  }

  // Return difference in format HH:MI between time1 and time2 
  static String diffHHMITime(String time1, String time2) {

     final int diffMin = diffMinTime(time1, time2);

     final int hour = diffMin~/60;
     final int minute = diffMin - hour*60;

     final String diffHour = hour.toString().padLeft(2, "0");
     final String diffMin0 = minute.toString().padLeft(2, "0");

     return "$diffHour:$diffMin0";
  }

  static String getHHMMFromMin( int minutes ) {
     final int hour = minutes~/60;
     final int minute = minutes - hour*60;

     final String diffHour = hour.toString().padLeft(2, "0");
     final String diffMin = minute.toString().padLeft(2, "0");

     return "$diffHour:$diffMin";
  }
  

  // Return minutes from String HH:MI 
  static int getMin(String time) {
     if ( time == '' ) return 0;
     int hour = int.parse(time.split(":")[0]);
     int minute = int.parse(time.split(":")[1]);

     return (hour*60+minute);
  }
}