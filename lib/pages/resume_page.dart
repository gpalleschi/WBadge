// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:badge/providers/day_provider.dart';
import 'package:badge/providers/param_provider.dart';
import 'package:badge/utility/time_utility.dart';
import 'package:badge/widgets/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResumePage extends StatelessWidget {
  const ResumePage({super.key});

  @override
  Widget build(BuildContext context) {

    final dayProvider = Provider.of<DayProvider>(context);
    final paramProvider = Provider.of<ParamProvider>(context, listen: false);

    // Compute Week Resume every time I enter
    final totWeekBalance = dayProvider.computeResumeWeek(paramProvider);

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Image(image: AssetImage('assets/iconBadge.png'), width: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('W-BADGE - ${AppLocalizations.of(context)!.resume}'),
              ),
            ],
          ),
      ), 
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 16, top: 8),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.balanceweek, style: const TextStyle(fontSize: 24, color: Colors.indigo, fontWeight: FontWeight.bold),),
                  Text(totWeekBalance.toString(),style: TextStyle(fontSize: 24, color: totWeekBalance >= 0 ? Colors.indigo : Colors.red, fontWeight: FontWeight.bold), )
                ],
                          ),
              ),
           const Divider(
                height: 20,
                thickness: 3,
                endIndent: 0,
                color: Colors.indigo,
              ),      
            Center(
                   child: Column(
                    
                      children:   
                    List.generate(TimeUtility.daysWeek.length, (index) {
                      return ExpandablePanel(
                              header:  Column(
                                children: [
                                  _TitleDayOfWeek(dayOfWeek: AppLocalizations.of(context)!.daysweek.split(":")[index] ),
                                  _RowResumeWeek(dayProvider: dayProvider, label: AppLocalizations.of(context)!.balance, value: dayProvider.resumeDay[index][dayProvider.labelResume[dayProvider.IDX_DAY_BALANCE]], color: dayProvider.getColor(dayProvider.IDX_DAY_BALANCE),),
                                ],
                              ),
                              theme: const ExpandableThemeData(iconColor: Colors.indigo, iconSize: 30),
                              expanded: Center(
                                child: Column(
                                  children: [
                                    _RowResumeWeek(dayProvider: dayProvider, label: AppLocalizations.of(context)!.totalhours, value: dayProvider.resumeDay[index][dayProvider.labelResume[dayProvider.IDX_TOT_HOURS]], color: dayProvider.getColor(dayProvider.IDX_TOT_HOURS)),
                                    _RowResumeWeek(dayProvider: dayProvider, label: AppLocalizations.of(context)!.totallunch, value: dayProvider.resumeDay[index][dayProvider.labelResume[dayProvider.IDX_TOT_CAFETERIA]], color: dayProvider.getColor(dayProvider.IDX_TOT_CAFETERIA)),
                                    _RowResumeWeek(dayProvider: dayProvider, label: AppLocalizations.of(context)!.numberbreaks, value: dayProvider.resumeDay[index][dayProvider.labelResume[dayProvider.IDX_NUM_PAUSES]], color: dayProvider.getColor(dayProvider.IDX_NUM_PAUSES)),
                                    _RowResumeWeek(dayProvider: dayProvider, label: AppLocalizations.of(context)!.totalbreaks, value: dayProvider.resumeDay[index][dayProvider.labelResume[dayProvider.IDX_TOT_PAUSES]],color: dayProvider.getColor(dayProvider.IDX_TOT_PAUSES)),
                                  ],
                                ),
                                  ), collapsed: Container(),
                              
                            );
                    }),
            )
            ),
           const Divider(
                height: 20,
                thickness: 3,
                endIndent: 0,
                color: Colors.indigo,
              ),          
            Padding(
                padding: const EdgeInsets.only(left: 8, right: 16, top: 8),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.totalhoursweek, style: const TextStyle(fontSize: 24, color: Colors.indigo, fontWeight: FontWeight.bold),),
                  Text(dayProvider.getWeekTotHours(),style: const TextStyle(fontSize: 24, color: Colors.indigo, fontWeight: FontWeight.bold), )
                ],
                          ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),);
  }
}

class _TitleDayOfWeek extends StatelessWidget {

  final String dayOfWeek;

  const _TitleDayOfWeek({
    Key? key,
    required this.dayOfWeek,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row( mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(dayOfWeek, style: const TextStyle(color: Colors.indigo, fontSize: 28, fontWeight: FontWeight.bold),),
      ],),
    );
  }
}

class _RowResumeWeek extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _RowResumeWeek({
    required this.dayProvider, required this.label, required this.value, required this.color,
  });

  final DayProvider dayProvider;


  @override
  Widget build(BuildContext context) {
    double sizeFont = 20;
    return Row( mainAxisAlignment: MainAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: SizedBox(width: MediaQuery.of(context).size.width/2.5, child: Text(label, style: TextStyle(color: Colors.indigo, fontSize: sizeFont) )),
    ),
    Text(' :  $value', style: TextStyle(color: color, fontSize: sizeFont) )
    ],);
  }
}