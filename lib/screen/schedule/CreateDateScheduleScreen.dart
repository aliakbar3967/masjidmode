import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/widgets/HelperWidgets.dart';
import 'package:provider/provider.dart';

class CreateDateScheduleScreen extends StatefulWidget {
  @override
  _CreateDateScheduleScreenState createState() =>
      _CreateDateScheduleScreenState();
}

class _CreateDateScheduleScreenState extends State<CreateDateScheduleScreen> {
  bool is24HoursFormat = false;
  TimeOfDay time;
  TimeOfDay picked;
  Schedule schedule = Schedule(
      name: "",
      type: "datetime",
      start: DateTime.now().toString(),
      end: DateTime.now().toString(),
      silent: true,
      vibrate: false,
      airplane: false,
      notify: false,
      saturday: true,
      sunday: true,
      monday: true,
      tuesday: true,
      wednesday: true,
      thursday: true,
      friday: true,
      status: false,
      isSelected: false);

  Future<Null> selectStartTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    final pickedTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));

    if (pickedDate != null && pickedTime != null) {
      setState(() {
        schedule.start = DateTime(pickedDate.year, pickedDate.month,
                pickedDate.day, pickedTime.hour, pickedTime.minute)
            .toString();
        schedule.end = DateTime(pickedDate.year, pickedDate.month,
                pickedDate.day, pickedTime.hour, pickedTime.minute)
            .toString();
      });
    }
  }

  Future<Null> selectEndTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(schedule.start),
      firstDate: DateTime.parse(schedule.start),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.parse(schedule.start)));

    if (pickedDate != null && pickedTime != null) {
      // final now = new DateTime.now();
      schedule.end = DateTime(pickedDate.year, pickedDate.month, pickedDate.day,
              pickedTime.hour, pickedTime.minute)
          .toString();
    }
  }

  Future<void> saveData() async {
    Provider.of<ScheduleProvider>(context, listen: false).add(schedule);
    Navigator.pop(context, true);
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () async {
      is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Create New Schedule".toUpperCase(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.calendar_today),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      SizedBox(height: 10.0),
                      Card(
                        elevation: 30,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: TextField(
                            onChanged: (String value) {
                              setState(() {
                                schedule.name = value;
                              });
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name...',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8 * 5.0),
                      Card(
                        child: GestureDetector(
                          onTap: () {
                            selectStartTime(context);
                          },
                          child: ListTile(
                            title: Text(
                              DateFormat.yMMMMd()
                                  .add_jm()
                                  .format(DateTime.parse(schedule.start))
                                  .toString(),
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text("Start DateTime"),
                            trailing: IconButton(
                              icon: Icon(Icons.alarm_add),
                              onPressed: () {
                                selectStartTime(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GestureDetector(
                          onTap: () {
                            selectEndTime(context);
                          },
                          child: ListTile(
                            title: Text(
                              DateFormat.yMMMMd()
                                  .add_jm()
                                  .format(DateTime.parse(schedule.end))
                                  .toString(),
                              style: TextStyle(color: Colors.blue),
                            ),
                            subtitle: Text("End DateTime"),
                            trailing: IconButton(
                              icon: Icon(Icons.alarm_add),
                              onPressed: () {
                                selectEndTime(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("Silent Mode"),
                          subtitle: Text("Phone will automatically silent."),
                          trailing: Transform.scale(
                            scale: 0.8,
                            alignment: Alignment.centerRight,
                            child: CupertinoSwitch(
                              value: schedule.silent,
                              activeColor: Colors.blue,
                              onChanged: (bool value) {
                                setState(() {
                                  schedule.silent = !schedule.silent;
                                  schedule.vibrate = !schedule.vibrate;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("Vibrate Mode"),
                          subtitle: Text("Phone will automatically vibrate."),
                          trailing: Transform.scale(
                            scale: 0.8,
                            alignment: Alignment.centerRight,
                            child: CupertinoSwitch(
                              value: schedule.vibrate,
                              activeColor: Colors.blue,
                              onChanged: (bool value) {
                                setState(() {
                                  schedule.silent = !schedule.silent;
                                  schedule.vibrate = !schedule.vibrate;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Icon(Icons.close),
                        autofocus: false,
                        style: OutlinedButton.styleFrom(
                            primary: Colors.redAccent,
                            shape: StadiumBorder(),
                            side: BorderSide(width: 2, color: Colors.redAccent),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16)),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (schedule.name == null || schedule.name == '') {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Oops! Schedule name required.',
                                style: TextStyle(color: Colors.black),
                              ),
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'OK',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (schedule.name.length > 10) {
                            final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                'Oops! Schedule name should be less than 10 characters',
                                style: TextStyle(color: Colors.black),
                              ),
                              action: SnackBarAction(
                                textColor: Colors.white,
                                label: 'OK',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            saveData();
                          }
                        },
                        child: Icon(Icons.done, color: Colors.blue),
                        autofocus:
                            (schedule.name != null && schedule.name != '')
                                ? true
                                : false,
                        style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(width: 2, color: Colors.blue),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16)),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
