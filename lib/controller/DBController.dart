import 'package:peace_time/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBController {
  static Future<bool> getIntroductionScreenStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constant.SP_INTRODUCTION);
  }

  static Future<void> toggleIntroductionScreenStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constant.SP_INTRODUCTION, value);
  }

  static Future<bool> getDefaultSchedulesStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constant.SP_DEFAULT_SCHEDULE);
  }

  static Future<bool> setDefaultSchedulesStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(Constant.SP_DEFAULT_SCHEDULE, value);
  }

  static Future<String> getSchedules() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constant.SP_SCHEDULES);
  }

  static Future<void> setSchedules(String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constant.SP_SCHEDULES, string);
  }

  static Future<bool> getNormalPeriod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constant.SP_NORMAL_PERIOD);
  }

  static Future<void> setNormalPeriod(bool bool) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constant.SP_NORMAL_PERIOD, bool);
  }
}