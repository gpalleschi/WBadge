import 'package:badge/providers/param_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LogoDialog extends StatelessWidget {
  const LogoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final paramProvider = Provider.of<ParamProvider>(context, listen: false);

    return AlertDialog(
          title: Text('W-BADGE', style: TextStyle(color: (Theme.of(context).textTheme.bodyLarge!.color)!, fontSize: 20, fontWeight: FontWeight.bold),),
          content: GestureDetector(
            onDoubleTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height/2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(image: const AssetImage('assets/skyballs.png'), width: MediaQuery.of(context).size.width/0.9,),
                  Text('${AppLocalizations.of(context)!.version} : ${paramProvider.version}', style: TextStyle(color: (Theme.of(context).textTheme.bodyLarge!.color)!, fontSize: 20 ),),
                  Text(paramProvider.skyballs, style: TextStyle(color: (Theme.of(context).textTheme.bodyLarge!.color)!, fontSize: 20 ),),
                ],
              ),
            ),
          ),
          // actions: <Widget>[ 
          //   TextButton(onPressed: () {Navigator.pop(context, AppLocalizations.of(context)!.yes);}, child: Text(AppLocalizations.of(context)!.yes, style: TextStyle(color: (Theme.of(context).textTheme.bodyLarge!.color)!, fontWeight: FontWeight.bold),)),
          // ],
        );
  }
}