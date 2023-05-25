import 'package:badge/utility/time_utility.dart';
import 'package:badge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:badge/providers/providers.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {

    final dayProvider = Provider.of<DayProvider>(context);

    return BottomNavigationBar(
      // Utizzo il setter della classe uiProvider
      type: BottomNavigationBarType.fixed,
      onTap: (index) async { 
        if ( dayProvider.menuSelected == index ) return;
        if ( index != 1 ) dayProvider.setMenuSelected(index);
        if ( index == 0 ) {
           Navigator.pushReplacementNamed(context, 'home');
           dayProvider.setMenuSelected(0);
        }
        if ( index == 1 ) {
           // If resume week exit 
           if ( dayProvider.menuSelected == 3 ) return;

           String? resDialog = '';
           if ( dayProvider.currentTimeStamps.isNotEmpty && dayProvider.menuSelected == 0 ) {
              resDialog = await showDialog<String>( context: context,
                                  builder: (BuildContext context) => CustomAlertDialog(title: 
                                  AppLocalizations.of(context)!.confirm, content: AppLocalizations.of(context)!.msgdelday(AppLocalizations.of(context)!.daysweek.split(":")[dayProvider.selDay]), type: 1),
                                );
           } else {
              if ( dayProvider.menuSelected == 2 ) {

                 resDialog = await showDialog<String>( context: context,
                                  builder: (BuildContext context) => CustomAlertDialog(title: 
                                  AppLocalizations.of(context)!.confirm, content: AppLocalizations.of(context)!.msgdelweek, type: 1),
                             );
              }
           }

           if ( resDialog == 'SI' ) {
                  // If in day page
                  if ( dayProvider.menuSelected == 0 ) {
                     dayProvider.reset();
                  } else {
                  // If in week page
                     dayProvider.resetWeek();

                  }
           }
        } 

        if ( index == 2 ) {
           Navigator.pushReplacementNamed(context, 'resume');
           dayProvider.setMenuSelected(2);
        }

        if ( index == 3 ) {
           Navigator.pushReplacementNamed(context, 'settings');
           dayProvider.setMenuSelected(3);
        }
      },
      elevation: 5,
      currentIndex: dayProvider.menuSelected,
      backgroundColor: Colors.indigo,
      fixedColor: Colors.white,
      unselectedItemColor: Colors.grey[500],
      items: [
      BottomNavigationBarItem(icon: const Icon(Icons.calendar_today, size: 30, color: Colors.white), label: AppLocalizations.of(context)!.day),
      BottomNavigationBarItem(icon: const Icon(Icons.restore_rounded, size: 30, color: Colors.white), label: AppLocalizations.of(context)!.reset ),
      BottomNavigationBarItem(icon: const Icon(Icons.table_chart, size: 30, color: Colors.white), label: AppLocalizations.of(context)!.resume),
      BottomNavigationBarItem(icon: const Icon(Icons.settings, size: 30, color: Colors.white), label: AppLocalizations.of(context)!.settings),
      ]);
  }
}