import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badge/providers/providers.dart';
import 'package:badge/widgets/widgets.dart';
import 'package:badge/models/type_time_stamp.dart';

class DayScreen extends StatelessWidget {
  const DayScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final dayProvider = Provider.of<DayProvider>(context);
    final paramProvider = Provider.of<ParamProvider>(context);

    return       // Bottoni
      SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
          // Day Selector
            SizedBox(
               height: MediaQuery.of(context).size.height/20,
               child: 
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                IconButton(icon: Icon(Icons.chevron_left_rounded, size: 30, color: dayProvider.selDay > 0 ? Theme.of(context).expansionTileTheme.iconColor : Theme.of(context).disabledColor), onPressed: dayProvider.selDay == 0 ? null : () { dayProvider.selLeftDay(Provider.of<ParamProvider>(context, listen: false));},),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(AppLocalizations.of(context)!.daysweek.split(':')[dayProvider.selDay], style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                ),
                IconButton(icon: Icon(Icons.chevron_right_rounded, size: 30, color: dayProvider.selDay < 6 ? Theme.of(context).expansionTileTheme.iconColor : Theme.of(context).disabledColor), onPressed: dayProvider.selDay == 6 ? null : () { dayProvider.selRigthDay(Provider.of<ParamProvider>(context, listen: false));},),
                ],)
              ),
              const Divider(
              height: 20,
              thickness: 3,
              endIndent: 0,
          ),

          SizedBox(
          height: MediaQuery.of(context).size.height/4.5,
          child: Center(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                               CustomButtonTimeStamp(label: AppLocalizations.of(context)!.enternow, iconData: Icons.input_rounded, typeTimeStamp: TypeTimeStamp.ENTRANCE, enabled: dayProvider.enableEntrance),
                               CustomButtonTimeStamp(label: AppLocalizations.of(context)!.startCaf, iconData: Icons.restaurant_rounded, typeTimeStamp: TypeTimeStamp.START_CAFETERIA, enabled: dayProvider.enableStartCafeteria),
                               CustomButtonTimeStamp(label: AppLocalizations.of(context)!.startbreak, iconData: Icons.coffee, typeTimeStamp: TypeTimeStamp.START_BREAK, enabled: dayProvider.enableStartBreak),
                               ],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                               CustomButtonTimeStamp(label: AppLocalizations.of(context)!.exitnow, iconData: Icons.output_rounded, typeTimeStamp: TypeTimeStamp.EXIT, enabled: dayProvider.enableExit),
                               CustomButtonTimeStamp(label: AppLocalizations.of(context)!.endlunch, iconData: Icons.restaurant_rounded, typeTimeStamp: TypeTimeStamp.END_CAFETERIA, enabled: dayProvider.enableEndCafeteria),
                               CustomButtonTimeStamp(label: AppLocalizations.of(context)!.endbreak, iconData: Icons.coffee, typeTimeStamp: TypeTimeStamp.END_BREAK, enabled: dayProvider.enableEndBreak),
                               ],),
              ],
             )
          ),
        ),
        const  Divider(
              height: 20,
              thickness: 3,
              endIndent: 0
            ),
        // Resume
        ExpandablePanel(
          // header: const Padding(
          //   padding: EdgeInsets.only(left: 10.0, top: 10.0),
          //   child: Text('Info Giorno', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25, fontWeight: FontWeight.bold),),
          // ),
          header: const Column( children: [
                                  _TitleDayResume(),
                                ],
                              ),
          theme: ExpandableThemeData(iconColor: Theme.of(context).expansionTileTheme.iconColor, iconSize: 30),
          expanded: Center(
             child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(dayProvider.labelResume.length, (index) {
                return _RowDayResume(dayProvider: dayProvider, label: AppLocalizations.of(context)!.labelresume.split(':')[index], value: dayProvider.resumeDay[dayProvider.selDay][dayProvider.labelResume[index]], color: dayProvider.getColorValue(dayProvider.selDay, dayProvider.labelResume[index]) > 0 ? (Theme.of(context).textTheme.bodyLarge!.color)! : Theme.of(context).hintColor);
              }),
              )), collapsed: 

                dayProvider.resumeDay[dayProvider.selDay][dayProvider.labelResume[dayProvider.IDX_EXP_EXIT]] == '' ?
                Container() :
              Column( 
                children: [ _RowDayResume(dayProvider: dayProvider, label: AppLocalizations.of(context)!.labelresume.split(':')[dayProvider.IDX_DAY_BALANCE], value: dayProvider.resumeDay[dayProvider.selDay][dayProvider.labelResume[dayProvider.IDX_DAY_BALANCE]], color: dayProvider.getColorValue(dayProvider.selDay, dayProvider.labelResume[dayProvider.IDX_DAY_BALANCE]) > 0 ? (Theme.of(context).textTheme.bodyLarge!.color)! : Theme.of(context).hintColor),
                            _RowDayResume(dayProvider: dayProvider, label: AppLocalizations.of(context)!.labelresume.split(':')[dayProvider.IDX_EXP_EXIT], value: dayProvider.resumeDay[dayProvider.selDay][dayProvider.labelResume[dayProvider.IDX_EXP_EXIT]], color: dayProvider.getColorValue(dayProvider.selDay, dayProvider.labelResume[dayProvider.IDX_EXP_EXIT]) > 0 ? (Theme.of(context).textTheme.bodyLarge!.color)! : Theme.of(context).hintColor),
                            _RowDayResume(dayProvider: dayProvider, label: AppLocalizations.of(context)!.labelresume.split(':')[dayProvider.IDX_EXP_EXIT_0], value: dayProvider.resumeDay[dayProvider.selDay][dayProvider.labelResume[dayProvider.IDX_EXP_EXIT_0]], color: dayProvider.getColorValue(dayProvider.selDay, dayProvider.labelResume[dayProvider.IDX_EXP_EXIT_0]) > 0 ? (Theme.of(context).textTheme.bodyLarge!.color)! : Theme.of(context).hintColor),]
              ),
          
        ),
        const Divider(
              height: 20,
              thickness: 3,
              endIndent: 0,
            ),
        // Lista Orari
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                    Container(width: 55, alignment: Alignment.center, child: Text(AppLocalizations.of(context)!.type, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
                    SizedBox(width: 70, child: Text(AppLocalizations.of(context)!.hour, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold) )),
                    const SizedBox(width: 50, child: Text('')),
                    const SizedBox(width: 50, child: Text('')),
        ]),
        Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: dayProvider.currentTimeStamps.isNotEmpty ?
            
            List.generate(dayProvider.currentTimeStamps.length, (index) {
              return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                               SizedBox(width: 55, child: dayProvider.getIcon(dayProvider.currentTimeStamps[index].type, 35, context)),
                               Container(width: 70, alignment: Alignment.center, child: Text(dayProvider.currentTimeStamps[index].time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ),)),
                               SizedBox(width: 50, child: CustomButtonClock(index: index,)),
                               const SizedBox(width: 20,),
                               SizedBox(width: 50, child: Padding(
                                 padding: const EdgeInsets.only(bottom: 4.0),
                                 child: IconButton(icon: const Icon(Icons.delete_rounded, size: 40), onPressed: () async { 
                                  String? ris = await showDialog<String>( context: context,
                                                      builder: (BuildContext context) => CustomAlertDialog(title: AppLocalizations.of(context)!.confirm, content: AppLocalizations.of(context)!.confirmdelmsg, type: 1),
                                                    );
                                  if ( ris == AppLocalizations.of(context)!.yes ) {
                                     dayProvider.deleleTimeStamp(index, paramProvider);
                                  }
                                 
                                 }, ),
                               )),
                    ]); 

            }) : [
              Column(
                children: [
                  const SizedBox(height: 50,),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //   ElevatedButton(onPressed: () { dayProvider.insertDefaultTimeStamps(Provider.of<ParamProvider>(context, listen: false)); },
                  // style: ElevatedButton.styleFrom(elevation: 10 ),
                  // child: Text(AppLocalizations.of(context)!.insertdeftime, style: const TextStyle(fontSize: 20),),),
                    OutlinedButton(onPressed: () { dayProvider.insertDefaultTimeStamps(Provider.of<ParamProvider>(context, listen: false)); },
                  //style: ElevatedButton.styleFrom(elevation: 10 ),
                  child: Text(AppLocalizations.of(context)!.insertdeftime, style: const TextStyle(fontSize: 20),),)

                  ],)
                ],
              )
            ],
           ),
        ),
         ]
        ),
      );
  }
}

class _TitleDayResume extends StatelessWidget {

  const _TitleDayResume({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row( mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(AppLocalizations.of(context)!.infoday, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
      ],),
    );
  }
}

class _RowDayResume extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _RowDayResume({
    required this.dayProvider, required this.label, required this.value, required this.color,
  });

  final DayProvider dayProvider;


  @override
  Widget build(BuildContext context) {
    double sizeFont = 20;
    return Row( mainAxisAlignment: MainAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: SizedBox(width: MediaQuery.of(context).size.width/2, child: Text(label, style: TextStyle( fontSize: sizeFont) )),
    ),
    const Text(' :    '),
    Text(value, style: TextStyle(color: color, fontSize: sizeFont) )
    ],);
  }
}