import 'package:badge/providers/day_provider.dart';
import 'package:badge/providers/param_provider.dart';
import 'package:badge/utility/time_utility.dart';
import 'package:badge/widgets/custom_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});


  @override
  Widget build(BuildContext context) {

    final paramProvider = Provider.of<ParamProvider>(context);
    const double fontSize = 20;

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Image(image: AssetImage('assets/iconBadge.png'), width: 40,),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text('W-BADGE - Impostazioni'),
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
              SizedBox(width: MediaQuery.of(context).size.width/2, child: const Text('Linguaggio ', style: TextStyle(color: Colors.indigo, fontSize: fontSize, fontWeight: FontWeight.bold),)),
              const SizedBox(width: 5,),
              SizedBox(width: MediaQuery.of(context).size.width/2.5, child: SizedBox(
                width: 40,
                child: DropdownButton( 
                                style : const TextStyle(color: Colors.indigo, fontSize: fontSize),
                                value: paramProvider.language,
                                items: const [DropdownMenuItem(value: "It", child: Text("Italiano")),
                                        DropdownMenuItem(value: "En", child: Text("English")),
                                        DropdownMenuItem(value: "Es", child: Text("Español")),], 
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
         const Divider( height: 20, thickness: 3, endIndent: 0, color: Colors.indigo,),
            // total day
          _RowParam(fontSize: fontSize, label: 'Orario Giorno', type: 'total_day', value: paramProvider.total_day,),
          _RowParam(fontSize: fontSize, label: 'Ora Min. Ingresso', type: 'min_time_entrance', value: paramProvider.min_time_entrance,),
          _RowParam(fontSize: fontSize, label: 'Ora Min. Uscita', type: 'min_time_exit', value: paramProvider.min_time_exit,),
         const Padding(
           padding: EdgeInsets.only(top: 5),
           child: Divider( height: 20, thickness: 3, endIndent: 0, color: Colors.indigo,),
         ),
          _RowParam(fontSize: fontSize, label: 'Tempo Minimo Pranzo', type: 'min_cafeteria', value: paramProvider.min_cafeteria,),
          _RowParam(fontSize: fontSize, label: 'Tempo Massimo Pranzo', type: 'max_cafeteria', value: paramProvider.max_cafeteria,),
          _RowParam(fontSize: fontSize, label: 'Tempo Min. Pranzo Cont.', type: 'min_cont_cafeteria', value: paramProvider.min_cont_cafeteria,),
          _RowParam(fontSize: fontSize, label: 'Tempo Max. Pranzo Cont.', type: 'max_cont_cafeteria', value: paramProvider.max_cont_cafeteria,),
         Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 5.0, left: 10.0),
      child: Row(children: [ SizedBox(width: MediaQuery.of(context).size.width/1.5, child: const Text('Richiesta Allarme per fine mensa', style: TextStyle(color: Colors.indigo, fontSize: fontSize, fontWeight: FontWeight.bold),)),
         Switch(value: paramProvider.check_alarm_caf, 
                activeColor: Colors.indigo,
                onChanged: (value) { paramProvider.setParam('check_alarm_caf', value?'true':'false');})])),
         const Padding(
           padding: EdgeInsets.only(top: 5),
           child: Divider( height: 20, thickness: 3, endIndent: 0, color: Colors.indigo,),
         ),
         Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 5.0, left: 10.0),
      child: Row(children: [ SizedBox(width: MediaQuery.of(context).size.width/1.5, child: const Text('Allarme per superamento pause', style: TextStyle(color: Colors.indigo, fontSize: fontSize, fontWeight: FontWeight.bold),)),
         Switch(value: paramProvider.check_tot_breaks, 
                activeColor: Colors.indigo,
                onChanged: (value) { paramProvider.setParam('check_tot_breaks', value?'true':'false');})])),
         // Totale Pause
         Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 5.0, left: 10.0),
      child: Row( children: [ SizedBox(width: MediaQuery.of(context).size.width/1.55, child: const Text('Massimo Numero Pause', style: TextStyle(color: Colors.indigo, fontSize: fontSize, fontWeight: FontWeight.bold),)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.indigo,),
            onPressed: () { 
              if ( int.parse(paramProvider.max_tot_breaks)-1 < 0 ) return;
              paramProvider.setParam('max_tot_breaks',(int.parse(paramProvider.max_tot_breaks) - 1).toString());
            },
          ),
          Text(paramProvider.max_tot_breaks, style: const TextStyle(color: Colors.indigo, fontSize: fontSize, fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.indigo),
            onPressed: () { 
              if ( int.parse(paramProvider.max_tot_breaks)+1 > paramProvider.max_incr_tot_breaks ) return;
              paramProvider.setParam('max_tot_breaks',(int.parse(paramProvider.max_tot_breaks) + 1).toString());
            },
          ),
        ],
      ),
                            //  Container( padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 8.0, left: 8.0),
                            //     child: Text(paramProvider.max_tot_breaks, style: TextStyle(color: Colors.indigo, fontSize: fontSize),),
                            //     alignment: Alignment.center,
                            //     decoration: BoxDecoration( border: Border.all(
                            //                                color: Colors.indigo, //                   <--- border color
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
      child: Row(children: [ SizedBox(width: MediaQuery.of(context).size.width/1.4, child: Text(label, style: TextStyle(color: Colors.indigo, fontSize: fontSize, fontWeight: FontWeight.bold),)),
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
                                                           color: Colors.indigo, //                   <--- border color
                                                           width: 2.0,
                                                         ),),
                                child: Text(value, style: TextStyle(color: Colors.indigo, fontSize: fontSize),),
                               ),
                             ),
      ]),
    );
  }
}