import 'package:badge/pages/day_screen.dart';
import 'package:badge/pages/pages.dart';
import 'package:badge/providers/providers.dart';

import 'package:badge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:badge/widgets/logo_dialog.dart';


class HomePage extends StatelessWidget {
   
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final dayProvider = Provider.of<DayProvider>(context);
    final paramProvider = Provider.of<ParamProvider>(context);

    // Resume every time I enter : 
    // FIXME: Search better solution
    dayProvider.computeResumeWeek(paramProvider);

    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
               GestureDetector(
                onDoubleTap: () async {
                  await showDialog<String>( context: context,
                              builder: (BuildContext context) => LogoDialog(),
                       );
                },
                child: const Image(image: AssetImage('assets/iconBadge.png'), width: 40,)),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('W-BADGE - ${dayProvider.menuSelected == 0 ? AppLocalizations.of(context)!.timestamps :  
                                         (dayProvider.menuSelected == 1 ? AppLocalizations.of(context)!.resume : 
                                                                          AppLocalizations.of(context)!.settings)}'),
              ),
            ],
          ),
          actions: <Widget>[ 
          IconButton(
            icon: const Icon(Icons.restore_rounded),
            tooltip: AppLocalizations.of(context)!.reset,
            onPressed: () async {
           if ( dayProvider.menuSelected == 3 ) return;

           String? resDialog = '';
           if ( dayProvider.currentTimeStamps.isNotEmpty && dayProvider.menuSelected == 0 ) {
              resDialog = await showDialog<String>( context: context,
                                  builder: (BuildContext context) => CustomAlertDialog(title: 
                                  AppLocalizations.of(context)!.confirm, content: AppLocalizations.of(context)!.msgdelday(AppLocalizations.of(context)!.daysweek.split(":")[dayProvider.selDay]), type: 1),
                                );
           } else {
              if ( dayProvider.menuSelected == 1 ) {

                 resDialog = await showDialog<String>( context: context,
                                  builder: (BuildContext context) => CustomAlertDialog(title: 
                                  AppLocalizations.of(context)!.confirm, content: AppLocalizations.of(context)!.msgdelweek, type: 1),
                             );
              }
           }

           if ( resDialog == AppLocalizations.of(context)!.yes ) {
                  // If in day page
                  if ( dayProvider.menuSelected == 0 ) {
                     dayProvider.reset();
                  } else {
                  // If in week page
                     dayProvider.resetWeek();

                  }
           }
           }
          ),
          ]
      ),
      body: dayProvider.flagLoad || paramProvider.flagLoad ? 
            const LoadingPage() : ( dayProvider.menuSelected == 0 ?
                                    const DayScreen() : 
                                    ( dayProvider.menuSelected == 1) ?
                                      const ResumePage() : const SettingsPage()
                                    ), 
      bottomNavigationBar: const CustomNavigationBar(),
      // Only if I haven't timestamps appears this botton
      // floatingActionButton: dayProvider.currentTimeStamps.isEmpty ? FloatingActionButton(onPressed: () { dayProvider.insertDefaultTimeStamps(); }, backgroundColor: Theme.of(context).primaryColor, child: const Icon(Icons.more_time_rounded, size: 40),) : null,
    );
  }
}