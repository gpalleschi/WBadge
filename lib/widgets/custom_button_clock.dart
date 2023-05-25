import 'package:badge/providers/providers.dart';
import 'package:badge/utility/utility.dart';
import 'package:badge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomButtonClock extends StatelessWidget {
  final int index;
  const CustomButtonClock({super.key, required this.index});
  


  @override
  Widget build(BuildContext context) {
    final dayProvider = Provider.of<DayProvider>(context);
    final paramProvider = Provider.of<ParamProvider>(context);

    return IconButton(onPressed: () async {
        var time = await showTimePicker( context: context, initialTime: TimeOfDay(hour:int.parse(dayProvider.currentTimeStamps[index].time.split(":")[0]),minute: int.parse(dayProvider.currentTimeStamps[index].time.split(":")[1])));
        if ( time != null ) {
          if ( TimeUtility.getHourMinute(time).compareTo(paramProvider.min_time_entrance) < 0 ) {
            await showDialog<String>( context: context,
                              builder: (BuildContext context) => CustomAlertDialog(title: AppLocalizations.of(context)!.warning, content: AppLocalizations.of(context)!.msgwarnbefminhourenter(paramProvider.min_time_entrance), type: 0),
                             );
            time = TimeOfDay(hour: int.parse(paramProvider.min_time_entrance.split(":")[0]), minute: int.parse(paramProvider.min_time_entrance.split(":")[1]));
          }

          final List<String> resUpdate = await dayProvider.updateTimeStamp(index, TimeUtility.getHourMinute(time), paramProvider);

          if ( resUpdate[0] != '' || resUpdate[1] != '' ) {
            String message = '';

            if ( resUpdate[0] != '' && resUpdate[1] != '' ) {
              message = AppLocalizations.of(context)!.msgerrtimestampbefaft(resUpdate[0],resUpdate[1]);
            } else {
              if ( resUpdate[0] != '' ) {
                 message = AppLocalizations.of(context)!.msgerrtimestampbef(resUpdate[0]);
              } else {
                 message = AppLocalizations.of(context)!.msgerrtimestampaft(resUpdate[1]);
              }
            }
            // ignore: use_build_context_synchronously
            await showDialog<String>( context: context,
                              builder: (BuildContext context) => CustomAlertDialog(title: AppLocalizations.of(context)!.error, content: message, type: 0),
                             );
          }

        }

    }, icon: const Icon(Icons.punch_clock_rounded), iconSize: 40, color: Colors.indigo,  );
  }
}