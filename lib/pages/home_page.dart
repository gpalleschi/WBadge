import 'package:badge/models/type_time_stamp.dart';
import 'package:badge/providers/providers.dart';
import 'package:badge/utility/time_utility.dart';
import 'package:badge/widgets/custom_button_timestamp.dart';
import 'package:badge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final dayProvider = Provider.of<DayProvider>(context);
    final paramProvider = Provider.of<ParamProvider>(context, listen: false);

    // Resume every time I enter : 
    dayProvider.computeResume(paramProvider,dayProvider.selDay);

    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: const [
              Image(image: AssetImage('assets/iconBadge.png'), width: 40,),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('W-BADGE - Timbrature'),
              ),
            ],
          ),
      ),
      body: 
      dayProvider.flagLoad ? 
         const Center(
           child: CircularProgressIndicator(),
         )
      :
      // Bottoni
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
                IconButton(icon: Icon(Icons.chevron_left_rounded, size: 30, color: dayProvider.selDay > 0 ? Colors.indigo : Colors.grey), onPressed: dayProvider.selDay == 0 ? null : () { dayProvider.selLeftDay(Provider.of<ParamProvider>(context, listen: false));},),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(TimeUtility.getDayById(dayProvider.selDay), style: const TextStyle(color: Colors.indigo, fontSize: 25, fontWeight: FontWeight.bold),),
                ),
                IconButton(icon: Icon(Icons.chevron_right_rounded, size: 30, color: dayProvider.selDay < 6 ? Colors.indigo : Colors.grey), onPressed: dayProvider.selDay == 6 ? null : () { dayProvider.selRigthDay(Provider.of<ParamProvider>(context, listen: false));},),
                ],)
              ),
          const Divider(
              height: 20,
              thickness: 3,
              endIndent: 0,
              color: Colors.indigo,
          ),

          SizedBox(
          height: MediaQuery.of(context).size.height/4.5,
          child: Center(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                               CustomButtonTimeStamp(label: 'Entro Ora', iconData: Icons.input_rounded, typeTimeStamp: TypeTimeStamp.ENTRANCE, enabled: dayProvider.enableEntrance),
                               CustomButtonTimeStamp(label: 'Inizio Mensa', iconData: Icons.restaurant_rounded, typeTimeStamp: TypeTimeStamp.START_CAFETERIA, enabled: dayProvider.enableStartCafeteria),
                               CustomButtonTimeStamp(label: 'Inizio Pausa', iconData: Icons.coffee, typeTimeStamp: TypeTimeStamp.START_BREAK, enabled: dayProvider.enableStartBreak),
                               ],),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                               CustomButtonTimeStamp(label: 'Esco Ora', iconData: Icons.output_rounded, typeTimeStamp: TypeTimeStamp.EXIT, enabled: dayProvider.enableExit),
                               CustomButtonTimeStamp(label: 'Fine Mensa', iconData: Icons.restaurant_rounded, typeTimeStamp: TypeTimeStamp.END_CAFETERIA, enabled: dayProvider.enableEndCafeteria),
                               CustomButtonTimeStamp(label: 'Fine Pausa', iconData: Icons.coffee, typeTimeStamp: TypeTimeStamp.END_BREAK, enabled: dayProvider.enableEndBreak),
                               ],),
              ],
             )
          ),
        ),
         const Divider(
              height: 20,
              thickness: 3,
              endIndent: 0,
              color: Colors.indigo,
            ),
        // Resume
        ExpandablePanel(
          // header: const Padding(
          //   padding: EdgeInsets.only(left: 10.0, top: 10.0),
          //   child: Text('Info Giorno', style: TextStyle(color: Colors.indigo, fontSize: 25, fontWeight: FontWeight.bold),),
          // ),
          header: Column(
                                children: [
                                  const _TitleDayResume(),
                                  _RowDayResume(dayProvider: dayProvider, label: dayProvider.labelResume[0], value: dayProvider.resumeDay[dayProvider.selDay][dayProvider.labelResume[0]], color: dayProvider.getColor(dayProvider.IDX_DAY_BALANCE),),
                                ],
                              ),
          theme: const ExpandableThemeData(iconColor: Colors.indigo, iconSize: 30),
          expanded: Center(
             child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(dayProvider.labelResume.length, (index) {
                if ( index == 0 ) {
                  return Container();
                } else {
                  return _RowDayResume(dayProvider: dayProvider, label: dayProvider.labelResume[index], value: dayProvider.resumeDay[dayProvider.selDay][dayProvider.labelResume[index]], color: dayProvider.colorValue[index] > 0 ? Colors.indigo : Colors.red);
                //   Padding(
                //     padding: const EdgeInsets.all(5.0),
                //     child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                //       Container(width: 200, alignment: Alignment.centerLeft, child: Text(dayProvider.labelResume[index], style: const TextStyle(fontSize: 20, color: Colors.indigo, fontWeight: FontWeight.bold),)),
                //       Container(width: 100, alignment: Alignment.center, child: Text(dayProvider.resumeDay[dayProvider.selDay][dayProvider.labelResume[index]], style: TextStyle(fontSize: 20, color: dayProvider.colorValue[index] > 0 ? Colors.indigo : Colors.red, fontWeight: FontWeight.bold),),),
                //     ]),
                // );
                }
              }),
              )), collapsed: Container(),
          
        ),
         const Divider(
              height: 20,
              thickness: 3,
              endIndent: 0,
              color: Colors.indigo,
            ),
        // Lista Orari
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                    Container(width: 50, alignment: Alignment.center, child: const Text('Tipo', style: TextStyle(fontSize: 24, color: Colors.indigo, fontWeight: FontWeight.bold),),),
                    const SizedBox(width: 70, child: Text('Orario', style: TextStyle(fontSize: 24, color: Colors.indigo, fontWeight: FontWeight.bold) )),
                    const SizedBox(width: 50, child: Text('')),
                    const SizedBox(width: 50, child: Text('')),
        ]),
        Center(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: dayProvider.currentTimeStamps.isNotEmpty ?
            
            List.generate(dayProvider.currentTimeStamps.length, (index) {
              return Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                               SizedBox(width: 50, child: dayProvider.getIcon(dayProvider.currentTimeStamps[index].type, 35)),
                               Container(width: 70, alignment: Alignment.center, child: Text(dayProvider.currentTimeStamps[index].time, style: const TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 20 ),)),
                               SizedBox(width: 50, child: CustomButtonClock(index: index,)),
                               const SizedBox(width: 20,),
                               SizedBox(width: 50, child: Padding(
                                 padding: const EdgeInsets.only(bottom: 4.0),
                                 child: IconButton(icon: const Icon(Icons.delete_rounded, size: 40, color: Colors.indigo), onPressed: () async { 
                                  String? ris = await showDialog<String>( context: context,
                                                      builder: (BuildContext context) => const CustomAlertDialog(title: 'Confermi', content: 'Cancellazione questa timbratura e successive?', type: 1),
                                                    );
                                  if ( ris == 'SI' ) {
                                     dayProvider.deleleTimeStamp(index, paramProvider);
                                  }
                                 
                                 }, ),
                               )),
                    ]); 

            }) : [
              Column(
                children: [
                  const SizedBox(height: 50,),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [ElevatedButton(onPressed: () { dayProvider.insertDefaultTimeStamps(Provider.of<ParamProvider>(context, listen: false)); },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, elevation: 10 ),
                  child: const Text('Inserisci Orario Default', style: TextStyle(color: Colors.white, fontSize: 20),),)],)
                ],
              )
            ],
           ),
        ),
         ]
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
      // Only if I haven't timestamps appears this botton
      // floatingActionButton: dayProvider.currentTimeStamps.isEmpty ? FloatingActionButton(onPressed: () { dayProvider.insertDefaultTimeStamps(); }, backgroundColor: Colors.indigo, child: const Icon(Icons.more_time_rounded, size: 40),) : null,
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
      child: Row( mainAxisAlignment: MainAxisAlignment.start, children: const [
      Text('Info Giorno', style: TextStyle(color: Colors.indigo, fontSize: 28, fontWeight: FontWeight.bold),),
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
      child: SizedBox(width: MediaQuery.of(context).size.width/2, child: Text(label, style: TextStyle(color: Colors.indigo, fontSize: sizeFont) )),
    ),
    Text(' :  $value', style: TextStyle(color: color, fontSize: sizeFont) )
    ],);
  }
}