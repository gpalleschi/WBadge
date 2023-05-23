import 'package:badge/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAlertDialog extends StatelessWidget {

  final String title;
  final String content;
  final int type; // 0 : ERROR - 1 : CONFIRM

  const CustomAlertDialog({super.key, required this.title, required this.content, required this.type});

  @override
  Widget build(BuildContext context) {
    // print('Type : ${type}');
    return AlertDialog(
          title: Text(title, style: TextStyle(color: (type == 1) ? Colors.indigo : Colors.red, fontSize: 20, fontWeight: FontWeight.bold),),
          content: Text(content, style: TextStyle(color: (type == 1) ? Colors.indigo : Colors.red, fontSize: 15,)),
          actions: <Widget>[ type == 1 ?
            TextButton(onPressed: () {Navigator.pop(context, 'NO');}, child: const Text('NO', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),))
            // IconButton(
            //   onPressed: () => Navigator.pop(context, 'NO'),
            //   icon: Icon(Icons.thumb_down_alt_rounded, color: Colors.red, size: 30,),
            // ) 
            : Container(),
            TextButton(onPressed: () {Navigator.pop(context, 'SI');}, child: const Text('SI', style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),)),
            // IconButton(
            //   onPressed: () {
            //     Navigator.pop(context, 'SI');
            //   },
            //   icon: Icon(Icons.thumb_up_rounded, color: (type == 1) ? Colors.indigo : Colors.red, size: 30),
            // ),
          ],
        );
  }
}