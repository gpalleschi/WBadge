import 'package:badge/models/time_stamp.dart';
import 'package:badge/models/type_time_stamp.dart';
import 'package:badge/providers/db_provider.dart';
import 'package:badge/themes/themes.dart';
import 'package:badge/utility/time_utility.dart';
import 'package:flutter/material.dart';

class ParamProvider extends ChangeNotifier {

  // Version to change
  String version = "1.0.6";
  String skyballs = "Skyballs 2023";

  bool flagLoad = false; 
  String language = 'it';

  final supportedLanguages = [ 'Italiano', 'English', 'Español' ];

  ThemeData currentThemeData = Default.themeData;
  String selectedTheme = 'default';

  final Map<String, ThemeData> themes = {
    'default' : Default.themeData,
    'dark' : Dark.themeData,
    'tim' : Tim.themeData,
    'ireland' : Ireland.themeData,
    'pink' : Pink.themeData,
    'dracula' : Dracula.themeData,
    'spreca' : Spreca.themeData, 
  };

  Map<String, ThemeData> get getThemes {
    return themes;
  }

  String get selTheme {
    return selectedTheme;
  }

  ThemeData get currThemeData {
    return currentThemeData;
  }

  set setCurrentThemeData(String nameTheme) {
    currentThemeData = themes[nameTheme]!;
  }

  bool check_alarm_caf = false;
  bool check_tot_breaks = false;
  bool round_seconds = false;
  String limit_round_seconds = '30';
  String max_tot_breaks = '0';
  int max_incr_tot_breaks = 9;
  String total_day = '08:38';
  String min_cafeteria = '00:25';
  String max_cafeteria = '01:00';
  String min_cont_cafeteria = '00:30';
  String max_cont_cafeteria = '01:00';  
  String min_time_entrance = '08:00';
  int min_hour_entrance = 8;
  int min_min_entrance = 0;
  String min_time_exit = '16:38';
  List<TimeStamp> defaultTimeStamps = [];

  String get minTimeEntrance {
    return min_time_entrance;
  }

  List<TimeStamp> get defTimeStamps {
     return defaultTimeStamps;
  }

  // Costructor
  ParamProvider() {
    flagLoad = true; 
    setParams();
    defaultTimeStamps = [TimeStamp(type: TypeTimeStamp.ENTRANCE, time:min_time_entrance),
                                       TimeStamp(type: TypeTimeStamp.START_CAFETERIA, time:"12:30"),
                                       TimeStamp(type: TypeTimeStamp.END_CAFETERIA, time:TimeUtility.addTime("12:30", min_cont_cafeteria)),
                                       TimeStamp(type: TypeTimeStamp.EXIT, time:min_time_exit),
                        ];

  }

  Future<String> getParam(String name, String defaultValue, String type) async {

    final ret = await DBProvider.db.getSettingString(name, defaultValue, type); 

    // print('Param : $name value : [$ret]');

    if ( ret != '' ) {
       return ret!;
    } else {
       return defaultValue;
    }
  }

  Future<bool> setParam(String type, String value) async {

    switch(type) {
      case 'language':
           language = value;
           break;
      case 'theme':
           selectedTheme = value;
           currentThemeData = themes[value]!;
           break;
      case 'check_alarm_caf':
           check_alarm_caf = (value == 'true') ? true : false;
           break;
      case 'check_tot_breaks':
           check_tot_breaks = (value == 'true') ? true : false;
           break;
      case 'max_tot_breaks':
           max_tot_breaks = value;
           break;
      case 'round_seconds':
           round_seconds = (value == 'true') ? true : false;
           break;
      case 'limit_round_seconds':
           limit_round_seconds = value;
           break;
      case 'total_day':
           total_day = value;
           break;
      case 'min_cafeteria':
           min_cafeteria = value;
           break;
      case 'max_cafeteria':
           max_cafeteria = value;
           break;
      case 'min_cont_cafeteria':
           min_cont_cafeteria = value;
           break;
      case 'max_cont_cafeteria':
           max_cont_cafeteria = value;
           break;
      case 'min_time_entrance':
           min_time_entrance = value;
           min_hour_entrance = int.parse(min_time_entrance.split(":")[0]);
           min_hour_entrance = int.parse(min_time_entrance.split(":")[1]);
           break;
      case 'min_time_exit':
           min_time_exit = value;
           break;
      default:
           return false;
    }

    await DBProvider.db.updateSetting(type, value);

    notifyListeners();

    return true;

  }

  Future<bool> setParams() async {
       language = await getParam('language', language, 'TEXT');
       selectedTheme = await getParam('theme', selectedTheme, 'TEXT');
       currentThemeData = themes[selectedTheme]!;
       total_day = await getParam('total_day', total_day, 'TEXT');
       min_cafeteria = await getParam('min_cafeteria', min_cafeteria, 'TEXT');
       max_cafeteria = await getParam('max_cafeteria', max_cafeteria, 'TEXT');
       min_cont_cafeteria = await getParam('min_cont_cafeteria', min_cont_cafeteria, 'TEXT');
       max_cont_cafeteria = await getParam('max_cont_cafeteria', max_cont_cafeteria, 'TEXT');
       min_time_entrance = await getParam('min_time_entrance', min_time_entrance, 'TEXT');
       min_hour_entrance = int.parse(min_time_entrance.split(":")[0]);
       min_hour_entrance = int.parse(min_time_entrance.split(":")[1]);
       min_time_exit = await getParam('min_time_exit', min_time_exit,'TEXT');
       check_tot_breaks = await getParam('check_tot_breaks', check_tot_breaks.toString(),'BOOLEAN') == 'false' ? false : true;
       check_alarm_caf = await getParam('check_alarm_caf', check_alarm_caf.toString(),'BOOLEAN') == 'false' ? false : true;
       max_tot_breaks = await getParam('max_tot_breaks', max_tot_breaks,'INT');
       round_seconds = await getParam('round_seconds', round_seconds.toString(),'BOOLEAN') == 'false' ? false : true;
       limit_round_seconds = await getParam('limit_round_seconds', limit_round_seconds,'INT');
       flagLoad = false;
       notifyListeners();
       return true;
  }

}