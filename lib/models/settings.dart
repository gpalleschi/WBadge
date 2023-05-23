import 'dart:convert';

Settings settingsFromMap(String str) => Settings.fromMap(json.decode(str));

String settingsToMap(Settings data) => json.encode(data.toMap());

class Settings {
    int id;
    String settingName;
    String settingValue;
    String settingType;

    Settings({
        required this.id,
        required this.settingName,
        required this.settingValue,
        required this.settingType,
    });

    factory Settings.fromMap(Map<String, dynamic> json) => Settings(
        id: json["id"],
        settingName: json["setting_name"],
        settingValue: json["setting_value"],
        settingType: json["setting_type"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "setting_name": settingName,
        "setting_value": settingValue,
        "setting_type": settingType,
    };

}