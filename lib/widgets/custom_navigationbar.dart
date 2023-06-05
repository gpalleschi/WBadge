import 'package:badge/utility/time_utility.dart';
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
        dayProvider.setMenuSelected(index);
      },
      //elevation: 5,
      currentIndex: dayProvider.menuSelected,
      //backgroundColor: Colors.indigo,
      fixedColor: Colors.white,
      //unselectedItemColor: Colors.grey[500],
      items: [
      BottomNavigationBarItem(icon: const Icon(Icons.calendar_today, size: 30,), label: AppLocalizations.of(context)!.day),
      BottomNavigationBarItem(icon: const Icon(Icons.table_chart, size: 30,), label: AppLocalizations.of(context)!.resume),
      BottomNavigationBarItem(icon: const Icon(Icons.settings, size: 30,), label: AppLocalizations.of(context)!.settings),
      ]);
  }
}