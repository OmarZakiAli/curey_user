import 'package:curey_user/helpers/notification_helper.dart';
import 'package:curey_user/models/adding_prescription_model.dart';
import 'package:curey_user/providers/prescriptionProvider.dart';
import 'package:curey_user/ui_widgets/app_drawer.dart';
import 'package:curey_user/ui_widgets/custom_bold_text.dart';
import 'package:curey_user/ui_widgets/custom_normal_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../../consts.dart';
import 'day_item.dart';

class AddPrescriptionScreen extends StatefulWidget {
  @override
  _AddPrescriptionScreenState createState() => _AddPrescriptionScreenState();
}

class _AddPrescriptionScreenState extends State<AddPrescriptionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _frequency = 0;
  final NotificationHelper _helper = NotificationHelper();
  AddingPrescriptionModel _addingPrescriptionModel =
      AddingPrescriptionModel(days: [], hours: []);

  final List _options = ["Day", "Week"];
  int _optionsIndex = 0;
  final List<Map> _days = [
    {"day": "Sa", "state": false, "Day": Day.Saturday},
    {"day": "Su", "state": false, "Day": Day.Sunday},
    {"day": "Mo", "state": false, "Day": Day.Monday},
    {"day": "Tu", "state": false, "Day": Day.Tuesday},
    {"day": "We", "state": false, "Day": Day.Wednesday},
    {"day": "Th", "state": false, "Day": Day.Thursday},
    {"day": "Fr", "state": false, "Day": Day.Friday},
  ];

  final _controller = TextEditingController();
  int _dosingInput = 1;
  List<DateTime> _dosingTimes = [];
  bool isEnabled = true;
  var fmt = DateFormat("HH:mm");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final presc = Provider.of<PrescriptionProvider>(context, listen: true);

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop()),
        title: customBoldText(
            text: "Add Prescription", color: Colors.black, size: 20),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              backgroundColor: Color(0xff09CACB),
            ),
          )
        ],
      ),
      body: presc.isLoading?Center(child:CircularProgressIndicator()): Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 12, color: Color(0xff7C7F87)),
                hintText: "Medication name-hint",
                contentPadding: EdgeInsets.only(top: 20, left: 20),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    customNormalText(
                        text: "Frequency", size: 14, color: Color(0xff7C7F87)),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              _frequency > 0 ? _frequency-- : _frequency;
                              _addingPrescriptionModel.frequency = _frequency;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(0xffF3F4F8),
                            radius: 20,
                            child: Center(
                                child: Icon(
                              Icons.minimize,
                              size: 12,
                              color: Colors.black,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: customBoldText(
                              text: _frequency.toString(),
                              size: 20,
                              color: Colors.black),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (_frequency < 11) {
                                _frequency++;
                                _addingPrescriptionModel.frequency = _frequency;
                              }
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(0xffF3F4F8),
                            radius: 20,
                            child: Center(
                                child: Icon(
                              Icons.add,
                              size: 14,
                              color: Colors.black,
                            )),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    customNormalText(
                        text: "Per", size: 14, color: Color(0xff7C7F87)),
                    SizedBox(
                      width: Sizes.getWidth(150) * width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          customBoldText(
                              text: _options[_optionsIndex], size: 20),
                          Column(
                            children: <Widget>[
                              InkWell(
                                child: Icon(Icons.arrow_drop_up),
                                onTap: () {
                                  setState(() {
                                    _optionsIndex = 1;
                                  });
                                },
                              ),
                              InkWell(
                                child: Icon(Icons.arrow_drop_down),
                                onTap: () {
                                  setState(() {
                                    _optionsIndex = 0;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            customBoldText(text: "Days in Week ", textAlign: TextAlign.left),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (con, index) {
                  return dayItem(
                      text: _days[index]["day"],
                      isSelected:
                          _optionsIndex == 0 ? true : _days[index]["state"],
                      onTap: () {
                        setState(() {
                          _days[index]["state"] = !_days[index]["state"];
                        });
                      });
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: customBoldText(
                  color: Colors.blue, text: "Dosing Times", size: 20),
            ),
            SizedBox(
              height: 8,
            ),
            _dosingTimes.length == 0
                ? Center(
                    child: InkWell(
                      child: CircleAvatar(
                          radius: 20,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 12,
                            ),
                          )),
                      onTap: () async {
                        setState(() {
                          DatePicker.showTime12hPicker(context,
                              showTitleActions: true, onConfirm: (t) {
                            setState(() {
                              _dosingTimes.add(t);
                            });
                          });
                        });
                      },
                    ),
                  )
                : SizedBox(
                    height: 130,
                    child: ListView.builder(
                        itemCount: _dosingTimes.length,
                        itemBuilder: (con, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                    flex: 4,
                                    child: Center(
                                      child: customNormalText(
                                          text: fmt.format(_dosingTimes[index]),
                                          size: 16),
                                    )),
                                Flexible(
                                  flex: 1,
                                  child: InkWell(
                                    child: CircleAvatar(
                                        radius: 20,
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                        )),
                                    onTap: () async {
                                      setState(() {
                                        DatePicker.showTime12hPicker(context,
                                            showTitleActions: true,
                                            onConfirm: (t) {
                                          setState(() {
                                            _dosingTimes.add(t);
                                          });
                                        });
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: InkWell(
                                    child: CircleAvatar(
                                        radius: 20,
                                        child: Center(
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                            size: 12,
                                          ),
                                        )),
                                    onTap: () {
                                      setState(() {
                                        _dosingTimes.removeAt(index);
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: InkWell(
                  onTap: !isEnabled
                      ? null
                      : () async {
                          isEnabled = false;

                          try {
                            _addingPrescriptionModel =
                                AddingPrescriptionModel(days: [], hours: []);

                            _frequency == 0 ? _frequency = 1 : _frequency;

                            _addingPrescriptionModel.frequency = _frequency;
                            _addingPrescriptionModel.medicineName =
                                _controller.value.text;

                            if (_dosingTimes.length == 1) {
                              _addingPrescriptionModel.auto = 1;
                              _addingPrescriptionModel.startHour =
                                  "${_dosingTimes[0].hour}:${_dosingTimes[0].minute}:${_dosingTimes[0].second}";
                            } else if (_dosingTimes.length > 1) {
                              _addingPrescriptionModel.auto = 0;
                              _addingPrescriptionModel.startHour =
                                  "${_dosingTimes[0].hour}:${_dosingTimes[0].minute}:${_dosingTimes[0].second}";
                            } else if (_dosingTimes.length == 0) {
                              Toast.show(
                                  "enter at least one dosing time", context);
                              _addingPrescriptionModel =
                                  AddingPrescriptionModel(days: [], hours: []);
                              isEnabled = true;
                              return;
                            }
                            DateTime dt = DateTime.now();

                            if (_optionsIndex == 0) {
                              for (int x = 1; x < 8; x++) {
                                _addingPrescriptionModel.days.add(x);
                              }

                              _dosingTimes.forEach((time) {
                                int hour = 0;
                                int min = 0;

                                dt = time;
                                hour = dt.hour;
                                min = dt.minute;
                                _addingPrescriptionModel.hours
                                    .add("$hour:$min:00");
                              });

                              //   _addingPrescriptionModel.days.length==0||_addingPrescriptionModel.frequency==null||_addingPrescriptionModel.frequency==0||_addingPrescriptionModel.hours.length==0?
                              //  Toast.show("enter valid data", context):

                              presc
                                  .addPrescription(_addingPrescriptionModel)
                                  .then((f) {
                                isEnabled = false;
                                _dosingTimes.forEach((time) {
                                  int hour = 0;
                                  int min = 0;

                                  dt = time;
                                  hour = dt.hour;
                                  min = dt.minute;

                                  _helper.showDailyNotification(f,
                                      time: Time(hour, min),
                                      medication: _addingPrescriptionModel
                                          .medicineName);
                                  print(Time(hour, min).toString());
                                });
                                Navigator.of(context).pop();
                              }, onError: (e) {
                                Toast.show(e.toString(), context);
                                _addingPrescriptionModel =
                                    AddingPrescriptionModel(
                                        days: [], hours: []);
                                isEnabled = true;
                                return;
                              });
                            } else if (_optionsIndex == 1) {
                              isEnabled = false;
                              _days.forEach((d) {
                                if (d["state"]) {
                                  _addingPrescriptionModel.days
                                      .add(_days.indexOf(d) + 1);
                                  print(d["state"]);
                                }
                              });

                              _dosingTimes.forEach((time) {
                                int hour = 0;
                                int min = 0;
                                dt = time;
                                hour = dt.hour;
                                min = dt.minute;
                                _addingPrescriptionModel.hours
                                    .add("$hour:$min:00");
                              });

                              presc
                                  .addPrescription(_addingPrescriptionModel)
                                  .then((onValue) {
                                isEnabled = false;
                                _days.forEach((d) {
                                  if (d["state"]) {
                                    _addingPrescriptionModel.days
                                        .add(_days.indexOf(d) + 1);
                                    print(d["state"]);

                                    _dosingTimes.forEach((time) {
                                      int hour = 0;
                                      int min = 0;
                                      dt = time;
                                      hour = dt.hour;
                                      min = dt.minute;
                                      _helper.showWeaklyNotification(onValue,
                                          time: Time(hour, min),
                                          day: d["Day"],
                                          medication: _addingPrescriptionModel
                                              .medicineName);
                                    });
                                  }
                                });
                                Navigator.of(context).pop();
                              }, onError: (e) {
                                Toast.show(e.toString(), context);
                                _addingPrescriptionModel =
                                    AddingPrescriptionModel(
                                        days: [], hours: []);
                                isEnabled = true;
                              });
                            }
                          } on Exception catch (_) {
                            isEnabled = true;
                            Toast.show(
                                "enter frequency and at least one dosig time data",
                                context);
                          }
                        },
                  child: Container(
                    width: 160,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff09CACB),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: customBoldText(
                            size: 14, color: Colors.white, text: "Add")),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ), //body
    ); //scaffold
  }
}
