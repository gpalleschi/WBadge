import 'package:badge/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAlertDialog extends StatelessWidget {

  final String title;
  final String content;
  final int type; // 0 : ERROR - 1 : CONFIRM

  const CustomAlertDialog({super.key, required this.title, required this.content, required this.type});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: Text(title, style: TextStyle(color: (type == 1) ? (Theme.of(context).textTheme.bodyLarge!.color)! : Theme.of(context).hintColor, fontSize: 20, fontWeight: FontWeight.bold),),
          content: Text(content, style: TextStyle(color: (type == 1) ? (Theme.of(context).textTheme.bodyLarge!.color)! : Theme.of(context).hintColor, fontSize: 15,)),
          actions: <Widget>[ type == 1 ?
            TextButton(onPressed: () {Navigator.pop(context, AppLocalizations.of(context)!.no);}, child: Text(AppLocalizations.of(context)!.no, style: TextStyle(color: Theme.of(context).hintColor, fontWeight: FontWeight.bold),))
            : Container(),
            TextButton(onPressed: () {Navigator.pop(context, AppLocalizations.of(context)!.yes);}, child: Text(AppLocalizations.of(context)!.yes, style: TextStyle(color: (Theme.of(context).textTheme.bodyLarge!.color)!, fontWeight: FontWeight.bold),)),
          ],
        );
  }
}