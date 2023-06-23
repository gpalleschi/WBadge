import 'package:badge/models/type_time_stamp.dart';
import 'package:badge/providers/providers.dart';
import 'package:badge/utility/time_utility.dart';
import 'package:badge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomButtonTimeStamp extends StatelessWidget {
  final String label;
  final IconData iconData;
  final int typeTimeStamp;
  final bool enabled;

  const CustomButtonTimeStamp({super.key, required this.label, required this.iconData, required this.typeTimeStamp, required this.enabled});

  @override
  Widget build(BuildContext context) {
    final dayProvider = Provider.of<DayProvider>(context);
    final paramProvider = Provider.of<ParamProvider>(context);

    Color? color = Theme.of(context).iconTheme.color;
    if ( typeTimeStamp == TypeTimeStamp.EXIT || 
         typeTimeStamp == TypeTimeStamp.END_BREAK || 
         typeTimeStamp == TypeTimeStamp.END_CAFETERIA ) {
      color = Theme.of(context).hintColor;
    }

    if ( !enabled ) {
      color = Colors.grey;
      if ( typeTimeStamp == TypeTimeStamp.EXIT || 
          typeTimeStamp == TypeTimeStamp.END_BREAK || 
          typeTimeStamp == TypeTimeStamp.END_CAFETERIA ) {
            color = const Color.fromRGBO(188, 143, 143, 0.5);
          
      }
    }  

    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [IconButton(onPressed: !enabled ? null : () async { 
                    DateTime now = DateTime.now();
                    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(now);
                    String timeToAdd = TimeUtility.getHourMinute(timeOfDay);

                    if ( now.second >= 30 ) {
                       timeToAdd = TimeUtility.addTime(timeToAdd,"00:01");
                    }

                    // Start Break
                    if ( typeTimeStamp == TypeTimeStamp.START_BREAK && paramProvider.check_tot_breaks == true && dayProvider.getCurrentBreaks()+1 > int.parse(paramProvider.max_tot_breaks) ) {
                       await showDialog<String>( context: context,
                                             builder: (BuildContext context) => CustomAlertDialog(title: AppLocalizations.of(context)!.titlealarmbreaks, content: AppLocalizations.of(context)!.msgalarmbreaks, type: 2),
                                             );
                    }

                    // Start Cafeteria 
                    if ( typeTimeStamp == TypeTimeStamp.START_CAFETERIA && paramProvider.check_alarm_caf == true ) {
                       String timeToAlarm = TimeUtility.addTime(timeToAdd,paramProvider.min_cafeteria);
                       String? ris = await showDialog<String>( context: context,
                                             builder: (BuildContext context) => CustomAlertDialog(title: AppLocalizations.of(context)!.titlealarmlunch, content: AppLocalizations.of(context)!.msgalarmlunch(timeToAlarm), type: 1),
                                             );
                       if ( ris == AppLocalizations.of(context)!.yes ) {
                          FlutterAlarmClock.createTimer(TimeUtility.getMin(paramProvider.min_cafeteria)*60,title: AppLocalizations.of(context)!.endlunch);
                       }                       

                    }

                    if ( typeTimeStamp == TypeTimeStamp.ENTRANCE && TimeUtility.getHourMinute(TimeOfDay.fromDateTime(DateTime.now())).compareTo(paramProvider.min_time_entrance) < 0 ) {
                       await showDialog<String>( context: context,
                              builder: (BuildContext context) => CustomAlertDialog(title: AppLocalizations.of(context)!.warning, content: AppLocalizations.of(context)!.msgwarnbefminhourenter(paramProvider.min_time_entrance), type: 0),
                       );
                       timeToAdd = paramProvider.min_time_entrance;
                    }

                    dayProvider.addNewTimeStamp(typeTimeStamp, timeToAdd, paramProvider); 

                  }, 
                  icon: Icon(iconData, color: color, size: 50,),
                 ),
                             Padding(padding: const EdgeInsets.only(left: 20, top: 5,),
                                     child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), ),
                                )
                               ],);
  }
}