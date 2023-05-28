import 'dart:io';

import 'package:badge/models/settings.dart';
import 'package:badge/models/time_stamp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';

class DBProvider {

  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {

    // La dicitura ??= significa se _database è nullo ritorno initDB() altrimenti _database
    return _database ??= await initDB();
  }

  Future<Database> initDB() async {

    var dbDirectory = await getDatabasesPath();
    
    // getApplicationDocumentsDirectory();
    // print('documentsDirectory.path : ${documentsDirectory.path}');
    // Join è presente in path.dart
    final path = join(dbDirectory,'WBadge.db' );
    // print('path : $path');
    return await openDatabase(
       path,
       version: 5,
       onOpen: (db) {
       },
       onCreate: ( Database db, int version ) async {
        // day : from 0 Monday to 6 Sunday
        // Type : ENTRANCE = 0;
        //        EXIT = 1;
        //        START_CAFETERIA = 2;
        //        END_CAFETERIA = 3;
        //        START_BREAK = 4;
        //        END_BREAK = 5;
        // time : String in format HH:MI
         await db.execute(''' CREATE TABLE WBadge ( id INTEGER PRIMARY KEY, day INTEGER, type INTEGER, time TEXT );''');
         // Settings table : setting_type (TEXT, INT, DOUBLE, BOOLEAN)
         await db.execute(''' CREATE TABLE WBadge_settings ( id INTEGER PRIMARY KEY, setting_name TEXT, setting_type TEXT, setting_value TEXT );''');
        // Default Settings
         await db.insert('WBadge_settings', {'setting_name' : 'language', 'setting_value' : 'it', 'setting_type' : 'TEXT'});
         await db.insert('WBadge_settings', {'setting_name' : 'theme', 'setting_value' : 'default', 'setting_type' : 'TEXT'});
         await db.insert('WBadge_settings', {'setting_name' : 'total_day', 'setting_value' : '08:38', 'setting_type' : 'TEXT'});
         await db.insert('WBadge_settings', {'setting_name' : 'min_cafeteria', 'setting_value' : '00:25', 'setting_type' : 'TEXT'});
         await db.insert('WBadge_settings', {'setting_name' : 'max_cafeteria', 'setting_value' : '01:00', 'setting_type' : 'TEXT'});
         await db.insert('WBadge_settings', {'setting_name' : 'min_cont_cafeteria', 'setting_value' : '00:30', 'setting_type' : 'TEXT'});
         await db.insert('WBadge_settings', {'setting_name' : 'max_cont_cafeteria', 'setting_value' : '01:00', 'setting_type' : 'TEXT'});
         await db.insert('WBadge_settings', {'setting_name' : 'min_time_entrance', 'setting_value' : '08:00', 'setting_type' : 'TEXT'});
         await db.insert('WBadge_settings', {'setting_name' : 'min_time_exit', 'setting_value' : '16:38', 'setting_type' : 'TEXT'});
         await db.insert('WBadge_settings', {'setting_name' : 'check_tot_breaks', 'setting_value' : 'false', 'setting_type' : 'BOOLEAN'});
         await db.insert('WBadge_settings', {'setting_name' : 'check_alarm_caf', 'setting_value' : 'false', 'setting_type' : 'BOOLEAN'});
         await db.insert('WBadge_settings', {'setting_name' : 'max_tot_breaks', 'setting_value' : '0', 'setting_type' : 'INT'});
       }
     );
  }

  // Get tutti i Scan
  Future<List<TimeStamp>> getAllTimeStamps() async {
    final db = await database;
    List<TimeStamp> timeStamps = [];

    final res = await db.query('WBadge', orderBy: "day");
    // print('res : ${res}');

    res.isNotEmpty
            ? {
             timeStamps = res.map( (s) => TimeStamp.fromMap(s) ).toList()
            }
            : timeStamps = [];
    return timeStamps;
  }

  // Delete all Scans
  Future<int> deleteAllTimeStamps() async {
    final db = await database;
    final res = await db.rawDelete(''' DELETE FROM WBadge''');
    return res;
  }

  // Delete one day
  Future<int> deleteTimeStampByDay(int day) async {
    final db = await database;
    final res = await db.delete('WBadge', where: 'day = ?', whereArgs: [day]);
    return res;
  }

  // Delete by ID 
  Future<int> deleteTimeStampById(int id) async {
    // print('DEBUG delete by Id : ${id}');
    final db = await database;
    final res = await db.delete('WBadge', where: 'id = ?', whereArgs: [id]);

    return res;
  }

  // Insert new TimeSTamp
  Future<int> newTimeStamp(TimeStamp newTS) async {
    final db = await database;
    final res = await db.insert('WBadge', newTS.toMap());
    // print('Insert ${res}');
    return res;
  }

  // Update TimeStamp
  Future<int> updateTimeStamp(TimeStamp upTS, newTime) async {
    final db = await database;
    final res = await db.rawUpdate('UPDATE WBadge SET time = ? WHERE id = ? and day = ? and type = ? ',
    [newTime, upTS.id, upTS.day, upTS.type]);
    return res;
  }

  // Update Param
  Future<int> updateSetting(String name, String value) async {
    final db = await database;
    final res = await db.rawUpdate('UPDATE WBadge_settings SET setting_value = ? WHERE setting_name = ? ', 
    [value,name]);

    // If Param not present Insert it
    if ( res == 0 ) {
      await db.insert('WBadge_settings', {'setting_name' : name, 'setting_value' : value, 'setting_type' : 'TEXT'}); 
    }
    return res;
  }

  // Get ParamText
  Future<String?> getSettingString(String settingName) async {
    final db = await database;

    final List<Map<String, dynamic>> ret = await db.rawQuery('SELECT setting_value FROM "WBadge_settings" WHERE setting_name = "$settingName"');

    // print('value : ${ret[0]['setting_value']}');

    return ret.isEmpty ? '' : ret[0]['setting_value'];
  }


}