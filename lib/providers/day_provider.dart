import 'package:badge/models/time_stamp.dart';
import 'package:badge/models/type_time_stamp.dart';
import 'package:badge/providers/db_provider.dart';
import 'package:badge/providers/param_provider.dart';
import 'package:flutter/material.dart';
import 'package:badge/utility/time_utility.dart';
import 'package:provider/provider.dart';

class DayProvider extends ChangeNotifier {

  int selDay = TimeUtility.getIdDayWeekNow();
  bool flagLoad = false;

  // List<TimeStamp> timeStamps = [];
  // List<List<TimeStamp>> timeStamps = List.generate(7, (index) => <TimeStamp>[]);
  List<TimeStamp> timeStamps = <TimeStamp>[];
  List<TimeStamp> currentTimeStamps = <TimeStamp>[];

  Future<int> getData() async {
    flagLoad = true;
    // print('Entro in GetData');
    // print('getData in Costructor');
    final allTimeStamps = await DBProvider.db.getAllTimeStamps();
    timeStamps = [...allTimeStamps];
    currentTimeStamps = timeStamps.where((ts) => ts.day == selDay).toList();
    setButtons();
    flagLoad = false;
    // print('Esco in GetData');
    notifyListeners();
    return 0;
  }

  // Costructor
  DayProvider() {
    getData();
  }

  // Menu Navigation Bar Selected 

  int menuSelected = 0;

  // Modality :

  final int MODALITY_BUTTONS = 0;
  final int MODALITY_TIME_UPDATE = 1;

  // Label x REsume
  final List<String> labelResume = [ 'Saldo Giorno','Tot Ore', 'Tot Mensa', 'Saldo Mensa', 'Uscita Prevista', 'Uscita Saldo 0',
                                     'Timbr. Min. Mensa', 'Fine Mensa Min.', 'Fine Mensa Max.', 'Tot Pause', 'Numero Pause'];
  final int IDX_DAY_BALANCE = 0;
  final int IDX_TOT_HOURS = 1;
  final int IDX_TOT_CAFETERIA = 2;
  final int IDX_CAF_BALANCE = 3;
  final int IDX_EXP_EXIT = 4;
  final int IDX_EXP_EXIT_0 = 5;
  final int IDX_MIN_TIMB_CAF = 6;
  final int IDX_MIN_END_CAF = 7;
  final int IDX_MAX_END_CAF = 8;
  final int IDX_TOT_PAUSES = 9;
  final int IDX_NUM_PAUSES = 10;

  //TODO: Load from DB Sqlite
  List<Map<String, dynamic>> resumeDay = List.generate(7, (index) =>{
    'Saldo Giorno'      : '',
    'Tot Ore'           : '',
    'Tot Mensa'         : '',
    'Saldo Mensa'       : '',
    'Uscita Prevista'   : '',
    'Uscita Saldo 0'    : '',
    'Timbr. Min. Mensa' : '',
    'Fine Mensa Min.'   : '',
    'Fine Mensa Max.'   : '',
    'Tot Pause'         : '',
    'Numero Pause'      : '',
  });

  String totHours = "00:00";
  double dayBalance = 0;
  String totCafeteria = "00:00";

  String expectedExit = "00:00";
  String expectedExitBalanceCero = "00:00";

  String minExitCafeteria = "00:00";
  String maxExitCafeteria = "00:00";

  // Bool botton status
  bool enableEntrance = true;
  bool enableExit = false;
  bool enableStartCafeteria = false;
  bool enableEndCafeteria = false;
  bool enableStartBreak = false;
  bool enableEndBreak = false;

  int getColorValue(int day, String type) {

    if ( resumeDay[day][type].length > 0 ) {
      if ( resumeDay[day][type][0] == '-' ) return 0;
    } 
    return 1;
  }

  //Get Week Balance
  int getWeekBalance() {
    int totResumeDay = 0;
    for(int idx=0;idx<TimeUtility.daysWeek.length;idx++) {
      if ( resumeDay[idx][labelResume[IDX_DAY_BALANCE]] != '' ) {
         totResumeDay += int.parse(resumeDay[idx][labelResume[IDX_DAY_BALANCE]]);
      }
    }
    return totResumeDay;
  }

  //Get Total Hours Week Worked
  String getWeekTotHours() {

    String totHoursWeek = '00:00';

    for(int idx=0;idx<TimeUtility.daysWeek.length;idx++) {
      if ( resumeDay[idx][labelResume[IDX_TOT_HOURS]] != '' ) {
         totHoursWeek = TimeUtility.addTotalTime(totHoursWeek, resumeDay[idx][labelResume[IDX_TOT_HOURS]]); 
      }
    }

    return totHoursWeek;

  }

  //Day Left
  void selLeftDay(ParamProvider paramProvider) {
    if ( selDay > 0 ) selDay--;
    currentTimeStamps = timeStamps.where((ts) => ts.day == selDay).toList();
    //reset();
    setButtons();
    notifyListeners();
  }

  //Day Rigth
  void selRigthDay(ParamProvider paramProvider) {
    if ( selDay < 6 ) selDay++;
    currentTimeStamps = timeStamps.where((ts) => ts.day == selDay).toList();
    //reset();
    setButtons();
    //computeResume(paramProvider);
    notifyListeners();
  }

  // Add New TimeStamp
  Future<int> addNewTimeStamp( int typeTimeStamp, String time, ParamProvider paramProvider) async {
    final newId = await DBProvider.db.newTimeStamp(TimeStamp(day: selDay, type: typeTimeStamp, time: time));
    timeStamps.add(TimeStamp(id: newId, day: selDay, type: typeTimeStamp, time: time));
    currentTimeStamps = timeStamps.where((ts) => ts.day == selDay).toList();
    notifyListeners();

    setForTypeTimeStamp(typeTimeStamp);

    notifyListeners();
    return timeStamps.length;
  }

  // Get Icon for Timestamp added
  Icon getIcon(int typeTimeStamp, double size, BuildContext context) {

    switch (typeTimeStamp) {
      case TypeTimeStamp.ENTRANCE:
        return Icon(Icons.input_rounded, size: size, color: Theme.of(context).iconTheme.color);
      case TypeTimeStamp.EXIT:
        return Icon(Icons.output_rounded, size: size, color: Theme.of(context).hintColor);
      case TypeTimeStamp.START_CAFETERIA:
        return Icon(Icons.restaurant_rounded, size: size, color: Theme.of(context).iconTheme.color);
      case TypeTimeStamp.END_CAFETERIA:
        return Icon(Icons.restaurant_rounded, size: size, color: Theme.of(context).hintColor);
      case TypeTimeStamp.START_BREAK:
        return Icon(Icons.coffee, size: size, color: Theme.of(context).iconTheme.color);
      case TypeTimeStamp.END_BREAK:
        return Icon(Icons.coffee, size: size, color: Theme.of(context).hintColor);
      default:
        return Icon(Icons.error, size: size, color: Theme.of(context).hintColor);
    } 
  }

  // Update a TimeStamp
  Future<List<String>> updateTimeStamp(int index, String newTime, ParamProvider paramProvider) async {

    final List<String> timeBefAft = [];
    bool error = false;

    // Check Before
    if ( index == 0 ) {
      timeBefAft.add('');
    } else {
      if ( TimeUtility.getMin(newTime) < TimeUtility.getMin(currentTimeStamps[index-1].time) ) {
         timeBefAft.add(currentTimeStamps[index-1].time);
         error = true;
      } else {
         timeBefAft.add('');
      }
    }
    // Check After
    if ( index == currentTimeStamps.length-1 ) {
       timeBefAft.add('');
    } else {
      if ( TimeUtility.getMin(newTime) > TimeUtility.getMin(currentTimeStamps[index+1].time) ) {
         timeBefAft.add(currentTimeStamps[index+1].time);
         error = true;
      } else {
         timeBefAft.add('');
      }
    }

    if ( !error ) {
       await DBProvider.db.updateTimeStamp(currentTimeStamps[index], newTime);
       await getData();
       currentTimeStamps = timeStamps.where((ts) => ts.day == selDay).toList();
       notifyListeners();
    }

    return timeBefAft;
  }

  // Set Buttons
  void setButtons() {
      int index = currentTimeStamps.length-1;

      if ( index < 0 ) {
        enableEntrance = true;
        enableExit = false;
        enableStartCafeteria = false;
        enableEndCafeteria = false;
        enableStartBreak = false;
        enableEndBreak = false;
        return;
      }

      if ( currentTimeStamps[index].type == TypeTimeStamp.ENTRANCE ) {
        enableEntrance = false;
        enableExit = true;
        enableStartCafeteria = true;
        enableEndCafeteria = false;
        enableStartBreak = true;
        enableEndBreak = false;
      } 
      if ( currentTimeStamps[index].type == TypeTimeStamp.START_CAFETERIA ) {
        enableStartCafeteria = false;
        enableEndCafeteria = true;
        enableStartBreak = false;
        enableExit = false;
      } 
      if ( currentTimeStamps[index].type == TypeTimeStamp.END_CAFETERIA ) {
        enableEndCafeteria = false;
        enableStartBreak = true;
        enableExit = true;
      }
      if ( currentTimeStamps[index].type == TypeTimeStamp.START_BREAK ) {
        enableStartBreak = false;
        enableEndBreak = true;
        enableStartBreak = false;
        enableExit = false;
      }
      if ( currentTimeStamps[index].type == TypeTimeStamp.END_BREAK ) {
        enableEndBreak = false;
        enableStartBreak = true;
        if ( !checkPresenceTypeTimeStamp(TypeTimeStamp.START_CAFETERIA) ) enableStartCafeteria = true;
        enableExit = true;
      }
      if ( currentTimeStamps[index].type == TypeTimeStamp.EXIT ) {
        enableEntrance = false;
        enableExit = false;
        enableStartCafeteria = false;
        enableEndCafeteria = false;
        enableStartBreak = false;
        enableEndBreak = false;

      } 
  }

  // Delete a TimeStamp
  void deleleTimeStamp(int index, ParamProvider paramProvider) async {
    if ( currentTimeStamps[index].type == TypeTimeStamp.ENTRANCE ) {
       reset();
       return;
    } 
    // Elimino dal punto in cui sto fino alla fine 
    int elemsToDel = currentTimeStamps.length-index;
    for(int i=0; i<(elemsToDel);i++) {
      await DBProvider.db.deleteTimeStampById(currentTimeStamps[index].id!);
      currentTimeStamps.removeAt(index);
    }
    await getData();
    setButtons();
    notifyListeners();
  }

  // Check presence of a typeTimeStamp
  bool checkPresenceTypeTimeStamp(int typeTimeStamp) {
      int index;
       for(index=0;index<currentTimeStamps.length;index++) {
          if ( currentTimeStamps[index].type == typeTimeStamp )  break;
       }
       if ( index == currentTimeStamps.length ) {
          return false;
       } else {
          return true;
       }
  }

  // Centralized Managment TypeTimeStamp with modality = 0 for button or 1 for update time
  // int setForTypeTimeStamp(int typeTimeStamp, String time, int modality) {
  void setForTypeTimeStamp(int typeTimeStamp) {

      if ( typeTimeStamp == TypeTimeStamp.ENTRANCE ){
            enableEntrance = false;
            enableExit = true;
            enableStartCafeteria = true;
            enableStartBreak = true;
      } 

      if ( typeTimeStamp == TypeTimeStamp.START_CAFETERIA ) {
            enableStartCafeteria = false;
            enableStartBreak = false;
            enableEndCafeteria = true;
            enableExit = false;
      }

      if ( typeTimeStamp == TypeTimeStamp.END_CAFETERIA ) {
            enableEndCafeteria = false;
            enableStartBreak = true;
            enableExit = true;
      } 

      if ( typeTimeStamp == TypeTimeStamp.START_BREAK ) {
            enableStartBreak = false;
            enableEndBreak = true;
            enableStartCafeteria = false;
            enableExit = false;
      }

      if ( typeTimeStamp == TypeTimeStamp.END_BREAK ) {
          enableEndBreak = false;
          enableStartBreak = true;

          if ( !checkPresenceTypeTimeStamp(TypeTimeStamp.START_CAFETERIA) ) enableStartCafeteria = true;
             enableExit = true;
      } 

      if ( typeTimeStamp == TypeTimeStamp.EXIT ) {
          enableExit = false;
          enableStartCafeteria = false;
          enableStartBreak = false;
      }

      return;
  }

  void setMenuSelected(int newSelection) {
    menuSelected = newSelection;
    notifyListeners();
  }

  void resetWeek() async {
       enableEntrance = true;
       enableExit = false;
       enableStartCafeteria = false;
       enableEndCafeteria = false;
       enableStartBreak = false;
       enableEndBreak = false;
       for(int idx=0;idx<resumeDay.length;idx++) {
          resumeDay[idx].updateAll((k,v) => v = ''); 
       }

       await DBProvider.db.deleteAllTimeStamps();
       await getData();
       currentTimeStamps.clear();
       notifyListeners();
  }

  void reset() async {

       enableEntrance = true;
       enableExit = false;
       enableStartCafeteria = false;
       enableEndCafeteria = false;
       enableStartBreak = false;
       enableEndBreak = false;
       resumeDay[selDay].updateAll((k,v) => v = ''); 

       await DBProvider.db.deleteTimeStampByDay(selDay);
       await getData();
       currentTimeStamps.clear();
       notifyListeners();
  }

  void insertDefaultTimeStamps(ParamProvider paramProvider) async {

    // Assign default TimeStamps
    //print('Entro in insert');
    for( TimeStamp timeStamp in paramProvider.defaultTimeStamps ) {
      final newId = await DBProvider.db.newTimeStamp(TimeStamp(day: selDay, type: timeStamp.type, time: timeStamp.time));
      timeStamp.id = newId;
      currentTimeStamps.add(timeStamp);
    }
    await getData();

    enableEntrance = false;
    enableExit = false;
    enableStartCafeteria = false;
    enableEndCafeteria = false;
    enableStartBreak = false;
    enableEndBreak = false;

    notifyListeners();
  }

  int computeResumeWeek(ParamProvider paramProvider) {
    // print('Enter in resume Week');
    for(int idx=0;idx<TimeUtility.daysWeek.length;idx++) {
      // print('Compute day $idx');
      computeResume(paramProvider, idx);
    }
    // print('out loop');
    return getWeekBalance();
  }

  void computeResume0(ParamProvider paramProvider, int dayToCompute) {

    // print('computeResume0 : ${resumeDay[selDay][labelResume[IDX_EXP_EXIT]].compareTo(paramProvider.min_time_exit)}');

    if ( resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]].compareTo(paramProvider.min_time_exit) > 0 ) {
            // Calcolo Totale saldo giorni precedenti
        int totSaldo = 0;
        for(int precDay=0;precDay<dayToCompute;precDay++) {
            if ( resumeDay[precDay][labelResume[IDX_DAY_BALANCE]] != '' ) {
               totSaldo+=int.parse(resumeDay[precDay][labelResume[IDX_DAY_BALANCE]]);
            }
        }
        // print('totSaldo : ${totSaldo}');
        if ( totSaldo > 0 ) {
            String timeExp = TimeUtility.diffHHMITime(resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]], TimeUtility.getHHMMFromMin(totSaldo));
            // print('timeExp : ${timeExp}');
            if ( timeExp.compareTo(paramProvider.min_time_exit) > 0 ) {
               resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT_0]] = timeExp;
            } else {
               resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT_0]] = paramProvider.min_time_exit;
            }
        } else {
            resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT_0]] = resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]];
        }

    } else {
        resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT_0]] = resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]];
    }

  }

  int getCurrentBreaks() {
    int totBreaks=0;

    for(int indx=0;indx<currentTimeStamps.length;indx++) {
      if ( currentTimeStamps[indx].type == TypeTimeStamp.START_BREAK ) totBreaks++;
    }

    return totBreaks;
  }

  // Calculate all resume
  void computeResume(ParamProvider paramProvider, int dayToCompute) {

    // print('DEBUG enter in resume');

    resumeDay[dayToCompute].updateAll((k,v) => v = ''); 

    List<TimeStamp> timeStampsToCompute = timeStamps.where((ts) => ts.day == dayToCompute).toList();

    // print('ts to compute : ${timeStampsToCompute.toString()}');
    for(int index=0; index<timeStampsToCompute.length; index++) {

      if ( timeStampsToCompute[index].type == TypeTimeStamp.ENTRANCE ) {
       // Calculo data uscita prevista
         resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]] = TimeUtility.addTime(timeStampsToCompute[index].time, paramProvider.total_day);
         computeResume0(paramProvider, dayToCompute);
      }  

      if ( timeStampsToCompute[index].type == TypeTimeStamp.START_CAFETERIA ) {
      // Tempo minimo Pausa Mensa
         resumeDay[dayToCompute][labelResume[IDX_MIN_END_CAF]] = TimeUtility.addTime(timeStampsToCompute[index].time, paramProvider.min_cont_cafeteria);
      // Tempo massimo Pausa Mensa
         resumeDay[dayToCompute][labelResume[IDX_MAX_END_CAF]] = TimeUtility.addTime(timeStampsToCompute[index].time, paramProvider.max_cont_cafeteria);
      // Timbratura minima Mensa
         resumeDay[dayToCompute][labelResume[IDX_MIN_TIMB_CAF]] = TimeUtility.addTime(timeStampsToCompute[index].time, paramProvider.min_cafeteria);
      }  

      if ( timeStampsToCompute[index].type == TypeTimeStamp.END_CAFETERIA ) {

         final String startTimeCaf = timeStampsToCompute[index-1].time;

         if ( startTimeCaf != '' ) {
            int iTotCafeteria = TimeUtility.diffMinTime(timeStampsToCompute[index].time, startTimeCaf); 
            // print('DEBUG: tot Cafeteria $iTotCafeteria');
            if ( iTotCafeteria <= TimeUtility.getMin(paramProvider.min_cont_cafeteria) ) {
              iTotCafeteria = TimeUtility.getMin(paramProvider.min_cont_cafeteria);
            } 
            resumeDay[dayToCompute][labelResume[IDX_TOT_CAFETERIA]] = TimeUtility.getHHMMFromMin(iTotCafeteria);
            resumeDay[dayToCompute][labelResume[IDX_CAF_BALANCE]] = ((iTotCafeteria-TimeUtility.getMin(paramProvider.max_cont_cafeteria))*-1).toString();
         } else {
            resumeDay[dayToCompute][labelResume[IDX_TOT_CAFETERIA]] = '00:00';
            resumeDay[dayToCompute][labelResume[IDX_CAF_BALANCE]] = '0';
         }

         if ( resumeDay[dayToCompute][labelResume[IDX_CAF_BALANCE]].toString().startsWith('-') ) {
           resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]] = TimeUtility.addTime(resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]], TimeUtility.diffHHMITime(resumeDay[dayToCompute][labelResume[IDX_TOT_CAFETERIA]],paramProvider.max_cont_cafeteria));

         } else {
           String newTimeExit = TimeUtility.subTime(resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]], resumeDay[dayToCompute][labelResume[IDX_TOT_CAFETERIA]]);
           if ( TimeUtility.diffMinTime(newTimeExit, paramProvider.min_time_exit) < 0 ) {
             resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]] = paramProvider.min_time_exit;
           } else {
             resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]] = newTimeExit;
           }
         }
         computeResume0(paramProvider, dayToCompute); 

      }

      if ( timeStampsToCompute[index].type == TypeTimeStamp.START_BREAK ) {
         if ( resumeDay[dayToCompute][labelResume[IDX_NUM_PAUSES]] == '' ) {
            resumeDay[dayToCompute][labelResume[IDX_NUM_PAUSES]] = '1';
         } else {
          resumeDay[dayToCompute][labelResume[IDX_NUM_PAUSES]] = (int.parse(resumeDay[dayToCompute][labelResume[IDX_NUM_PAUSES]])+1).toString();
         }
      }

      if ( timeStampsToCompute[index].type == TypeTimeStamp.END_BREAK ) {
        // Sommo durate pausa

        String sTotPause = TimeUtility.diffHHMITime(timeStampsToCompute[index].time, timeStampsToCompute[index-1].time);
        if ( resumeDay[dayToCompute][labelResume[IDX_TOT_PAUSES]] == '' ) {
           resumeDay[dayToCompute][labelResume[IDX_TOT_PAUSES]] = sTotPause;
        } else {
           resumeDay[dayToCompute][labelResume[IDX_TOT_PAUSES]] = TimeUtility.addTime(resumeDay[dayToCompute][labelResume[IDX_TOT_PAUSES]], sTotPause);

        }

        resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]] = TimeUtility.addTime(resumeDay[dayToCompute][labelResume[IDX_EXP_EXIT]], resumeDay[dayToCompute][labelResume[IDX_TOT_PAUSES]]);
        computeResume0(paramProvider, dayToCompute); 
      }

      if ( timeStampsToCompute[index].type == TypeTimeStamp.EXIT ) {

         String sTotDay = TimeUtility.diffHHMITime(timeStampsToCompute[index].time, timeStampsToCompute[0].time).toString();
         int mTotDay = TimeUtility.getMin(sTotDay);
        //  print('mTotDay : $mTotDay');
         int iResumeDay = TimeUtility.diffMinTime(timeStampsToCompute[index].time, timeStampsToCompute[0].time)-TimeUtility.getMin(paramProvider.total_day);
        //  print('iResumeDay 1 : $iResumeDay');
         if ( resumeDay[dayToCompute][labelResume[IDX_CAF_BALANCE]] == '' ) {
            // print('Caf blanca ');
            resumeDay[dayToCompute][labelResume[IDX_CAF_BALANCE]] = (TimeUtility.getMin(paramProvider.max_cafeteria)*-1).toString();
            resumeDay[dayToCompute][labelResume[IDX_TOT_CAFETERIA]] = paramProvider.max_cafeteria;
            mTotDay += TimeUtility.getMin(paramProvider.max_cont_cafeteria)*-1;
         } else {
            // print('Caf : ' + resumeDay[dayToCompute][labelResume[IDX_CAF_BALANCE]]);
            mTotDay += int.parse(resumeDay[dayToCompute][labelResume[IDX_CAF_BALANCE]]);
            iResumeDay += TimeUtility.getMin(paramProvider.max_cont_cafeteria) - TimeUtility.getMin(resumeDay[dayToCompute][labelResume[IDX_TOT_CAFETERIA]]);
            iResumeDay -= TimeUtility.getMin(resumeDay[dayToCompute][labelResume[IDX_TOT_PAUSES]]);
         }
        //  print('iResumeDay 2 : $iResumeDay');
         resumeDay[dayToCompute][labelResume[IDX_TOT_HOURS]] = TimeUtility.getHHMMFromMin(mTotDay);

         resumeDay[dayToCompute][labelResume[IDX_DAY_BALANCE]] = iResumeDay.toString();

        //  print('iResumeDay : $iResumeDay');

         computeResume0(paramProvider,dayToCompute);
      }

    }
  }
}