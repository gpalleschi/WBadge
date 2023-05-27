import 'package:badge/main.dart';
import 'package:badge/providers/day_provider.dart';
import 'package:badge/providers/param_provider.dart';
import 'package:badge/utility/time_utility.dart';
import 'package:badge/widgets/custom_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});


  @override
  Widget build(BuildContext context) {

    final paramProvider = Provider.of<ParamProvider>(context);
    const double fontSize = 20;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Image(image: AssetImage('assets/iconBadge.png'), width: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('W-BADGE - ${AppLocalizations.of(context)!.settings}'),
              ),
            ],
          ),
      ), 
      body: SingleChildScrollView(
        child: Column(children: [

          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
            // Language
            child: Row(children: [
              SizedBox(width: MediaQuery.of(context).size.width/2, child: Text(AppLocalizations.of(context)!.language, style: const TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),)),
              const SizedBox(width: 5,),
              SizedBox(width: MediaQuery.of(context).size.width/2.5, child: SizedBox(
                width: 40,
                child: DropdownButton( 
                                dropdownColor: Theme.of(context).dialogBackgroundColor,
                                iconEnabledColor: Theme.of(context).expansionTileTheme.iconColor,
                                style : const TextStyle(fontSize: fontSize),
                                value: paramProvider.language,
                                items: [DropdownMenuItem(value: "it", child: Text(AppLocalizations.of(context)!.italian, style: TextStyle(color: (Theme.of(context).dropdownMenuTheme.textStyle!.color)) )),
                                        DropdownMenuItem(value: "en", child: Text(AppLocalizations.of(context)!.english, style: TextStyle(color: (Theme.of(context).dropdownMenuTheme.textStyle!.color)) )),
                                        DropdownMenuItem(value: "es", child: Text(AppLocalizations.of(context)!.spanish, style: TextStyle(color: (Theme.of(context).dropdownMenuTheme.textStyle!.color)) )),], 
                                        onChanged: (String? value) { 
                                          if ( value != null && value != '' ) {
                                             paramProvider.setParam('language', value);
                                            //  print('value : $value');
                                          }
                                        },  
                ),
              )),

            ],),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
            // Language
            child: Row(children: [
              SizedBox(width: MediaQuery.of(context).size.width/2, child: Text(AppLocalizations.of(context)!.theme, style: const TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),)),
              const SizedBox(width: 5,),
              SizedBox(width: MediaQuery.of(context).size.width/2.5, child: SizedBox(
                width: 40,
                child: DropdownButton( 
                                dropdownColor: Theme.of(context).dialogBackgroundColor,
                                iconEnabledColor: Theme.of(context).expansionTileTheme.iconColor,
                                style : const TextStyle(fontSize: fontSize),
                                value: paramProvider.selTheme,
                                items: _getThemes(paramProvider, context),
                                onChanged: (String? value) { 
                                          if ( value != null && value != '' ) {
                                             paramProvider.setParam('theme', value);
                                            //  print('value : $value');
                                          }
                                        },  
                ),
              )),

            ],),
          ),
          const Divider( height: 20, thickness: 3, endIndent: 0,),
            // total day
          _RowParam(fontSize: fontSize, label: AppLocalizations.of(context)!.hourday, type: 'total_day', value: paramProvider.total_day,),
          _RowParam(fontSize: fontSize, label: AppLocalizations.of(context)!.hourminenter, type: 'min_time_entrance', value: paramProvider.min_time_entrance,),
          _RowParam(fontSize: fontSize, label: AppLocalizations.of(context)!.hourminexit, type: 'min_time_exit', value: paramProvider.min_time_exit,),
         const Padding(
           padding: const EdgeInsets.only(top: 5),
           child: Divider( height: 20, thickness: 3, endIndent: 0),
         ),
          _RowParam(fontSize: fontSize, label: AppLocalizations.of(context)!.mintimelunch, type: 'min_cafeteria', value: paramProvider.min_cafeteria,),
          _RowParam(fontSize: fontSize, label: AppLocalizations.of(context)!.maxtimelunch, type: 'max_cafeteria', value: paramProvider.max_cafeteria,),
          _RowParam(fontSize: fontSize, label: AppLocalizations.of(context)!.mintimelunchcont, type: 'min_cont_cafeteria', value: paramProvider.min_cont_cafeteria,),
          _RowParam(fontSize: fontSize, label: AppLocalizations.of(context)!.maxtimelunchcont, type: 'max_cont_cafeteria', value: paramProvider.max_cont_cafeteria,),
         Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 5.0, left: 10.0),
      child: Row(children: [ SizedBox(width: MediaQuery.of(context).size.width/1.5, child: Text(AppLocalizations.of(context)!.reqalarmlunch, style: const TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),)),
         Switch( value: paramProvider.check_alarm_caf, 
                activeColor: Theme.of(context).iconTheme.color,
                onChanged: (value) { paramProvider.setParam('check_alarm_caf', value?'true':'false');})])),
          const Padding(
           padding: EdgeInsets.only(top: 5),
           child: Divider( height: 20, thickness: 3, endIndent: 0),
         ),
         Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 5.0, left: 10.0),
      child: Row(children: [ SizedBox(width: MediaQuery.of(context).size.width/1.5, child: Text(AppLocalizations.of(context)!.reqalarmmaxbreaks, style: const TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),)),
         Switch( value: paramProvider.check_tot_breaks, 
                activeColor: Theme.of(context).iconTheme.color,
                inactiveThumbColor: Theme.of(context).iconTheme.color,
                inactiveTrackColor: Theme.of(context).disabledColor,
                onChanged: (value) { paramProvider.setParam('check_tot_breaks', value?'true':'false');})])),
         // Totale Pause
         Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 5.0, left: 10.0),
      child: Row( children: [ SizedBox(width: MediaQuery.of(context).size.width/1.55, child: Text(AppLocalizations.of(context)!.maxbreaks, style: const TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: Theme.of(context).iconTheme.color,),
            onPressed: () { 
              if ( int.parse(paramProvider.max_tot_breaks)-1 < 0 ) return;
              paramProvider.setParam('max_tot_breaks',(int.parse(paramProvider.max_tot_breaks) - 1).toString());
            },
          ),
          Text(paramProvider.max_tot_breaks, style: const TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
          IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).iconTheme.color),
            onPressed: () { 
              if ( int.parse(paramProvider.max_tot_breaks)+1 > paramProvider.max_incr_tot_breaks ) return;
              paramProvider.setParam('max_tot_breaks',(int.parse(paramProvider.max_tot_breaks) + 1).toString());
            },
          ),
        ],
      ),
                            //  Container( padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 8.0, left: 8.0),
                            //     child: Text(paramProvider.max_tot_breaks, style: TextStyle(color: Theme.of(context).primaryColor, fontSize: fontSize),),
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration( border: Border.all(
                            //                                color: Theme.of(context).primaryColor, //                   <--- border color
                            //                                width: 2.0,
                            //                              ),),
                            //    ),

                ])),

         //_RowParam(fontSize: fontSize, label: 'Massimo Numero Pause', type: 'max_tot_breaks', value: paramProvider.max_tot_breaks,),

        ],)

      ),
      bottomNavigationBar: const CustomNavigationBar(),
      
      );
  }

}

class _RowParam extends StatelessWidget {
  const _RowParam({
    required this.fontSize, required this.label, required this.value, required this.type,
  });

  final double fontSize;
  final String label;
  final String value;
  final String type;

  @override
  Widget build(BuildContext context) {
    final paramProvider = Provider.of<ParamProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 5.0, left: 10.0),
      child: Row(children: [ SizedBox(width: MediaQuery.of(context).size.width/1.4, child: Text(label, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),)),
                             GestureDetector(
                               onTap: () async {
                                      var time = await showTimePicker( context: context, 
                                                                      builder: (context, child) { 
                                                                        return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: (type == 'min_time_entrance' || type == 'min_time_exit') ? false : true),
                                                                        child: child!);
                                                                      },
                                                                      initialTime: TimeOfDay(hour:int.parse(value.split(":")[0]),minute: int.parse(value.split(":")[1])));
                                      
                                      if ( time != null ) {
                                        paramProvider.setParam(type, TimeUtility.getHourMinute(time));
                                      }
                               },
                               child: Container(
                                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 8.0, left: 8.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration( border: Border.all(
                                                           color: Theme.of(context).dividerColor, //                   <--- border color
                                                           width: 2.0,
                                                         ),),
                                child: Text(value, style: TextStyle(fontSize: fontSize),),
                               ),
                             ),
      ]),
    );
  }
}


List<DropdownMenuItem<String>> _getThemes(ParamProvider paramProvider, BuildContext context) {
   List<DropdownMenuItem<String>> retList = [];

   paramProvider.themes.forEach((key, value) { retList.add(
     DropdownMenuItem(value: key, child: Text(key, style: TextStyle(color: (Theme.of(context).dropdownMenuTheme.textStyle!.color)))));
   });

   return retList;
} 