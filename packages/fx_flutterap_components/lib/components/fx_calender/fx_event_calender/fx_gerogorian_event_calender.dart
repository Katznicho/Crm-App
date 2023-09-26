// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fx_flutterap_components/components/fx_button/fx_button.dart';
import 'package:fx_flutterap_components/components/fx_form/fx_text_field/fx_text_field.dart';
import 'package:fx_flutterap_components/components/fx_spacer/fx_v_spacer.dart';
import 'package:fx_flutterap_components/components/fx_text/fx_text.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_config.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_dims.dart';
import 'package:fx_flutterap_template/default_template/structure/structure_styles.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'fx_english_date_picker.dart';

class FxGeogorianEventCalender extends StatefulWidget {
  const FxGeogorianEventCalender({Key? key}) : super(key: key);

  @override
  State<FxGeogorianEventCalender> createState() =>
      _FxGeogorianEventCalenderState();
}

class _FxGeogorianEventCalenderState extends State<FxGeogorianEventCalender> {
  final List<Appointment> _appointments = <Appointment>[];
  final CalendarController _calendarController = CalendarController();
  final TextEditingController _addController = TextEditingController();
  final TextEditingController _editController = TextEditingController();

  late Appointment _draggedAppointment;
  late DateTime _newAppointmentDate;

  DateTime _date = DateTime.now();
  DateTime _dateAdd = DateTime.now();

  // ignore: prefer_final_fields
  DateTime _dateEdit = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Add some sample appointments
    _appointments.add(
      Appointment(
        startTime: DateTime.now().add(const Duration(days: 1)),
        endTime: DateTime.now().add(const Duration(days: 1, hours: 1)),
        subject: 'Event 1',
        color: InitialStyle.primaryColor,
      ),
    );

    _appointments.add(
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 3)),
          endTime: DateTime.now().add(const Duration(days: 7, hours: 1)),
          subject: 'Event 2',
          color: InitialStyle.primaryColor),
    );
    _appointments.add(
      Appointment(
          startTime: DateTime.now().add(const Duration(days: 7)),
          endTime: DateTime.now().add(const Duration(days: 7, hours: 1)),
          subject: 'Event 3',
          color: InitialStyle.primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: InitialDims.space25 * 6,
      padding: EdgeInsets.all(InitialDims.space5),
      decoration: BoxDecoration(
          color: InitialStyle.section,
          borderRadius: BorderRadius.all(Radius.circular(InitialDims.border5))),
      child: SfCalendar(
        view: CalendarView.month,
        controller: _calendarController,
        dataSource: _getDataSource(),
        headerStyle: CalendarHeaderStyle(
            textStyle: TextStyle(
                fontFamily: InitialConfig.fontFamily,
                color: InitialStyle.titleTextColor,
                fontSize: InitialDims.titleFontSize)),
        viewHeaderStyle: ViewHeaderStyle(
          dayTextStyle: TextStyle(
              fontFamily: InitialConfig.fontFamily,
              color: InitialStyle.titleTextColor,
              fontSize: InitialDims.normalFontSize),
        ),
        appointmentBuilder: _appointmentBuilder,
        monthCellBuilder: _monthCellBuilder,
        todayTextStyle: TextStyle(
            fontFamily: InitialConfig.fontFamily,
            color: InitialStyle.titleTextColor,
            fontSize: InitialDims.titleFontSize),
        selectionDecoration: BoxDecoration(
          border: Border.all(
            color: InitialStyle.primaryColor,
          ),
          borderRadius: BorderRadius.circular(InitialDims.border1),
        ),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        todayHighlightColor: InitialStyle.specificColor,
        allowDragAndDrop: true,
        allowAppointmentResize: true,
        onTap: (detail) {
          setState(() {
            _date = detail.date ?? DateTime.now();
            _dateAdd = detail.date ?? DateTime.now();
          });
          _addEvent(context);
        },
        onLongPress: (details) {
          _draggedAppointment = details.appointments!.first;
          _newAppointmentDate = details.date!;
          setState(() {});
        },
        onDragUpdate: (details) {
          // _newAppointmentDate = details.date;
          setState(() {});
        },
        onDragEnd: (details) {
          _draggedAppointment.startTime =
              _newAppointmentDate.subtract(const Duration(hours: 1));
          _draggedAppointment.endTime = _newAppointmentDate;
          setState(() {});
        },
      ),
    );
  }

  Widget _appointmentBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    if (details.isMoreAppointmentRegion) {
      return SizedBox(
        width: details.bounds.width,
        height: details.bounds.height,
        child: InkWell(
          child: FxText(
            '+More',
            color: InitialStyle.primaryColor,
            tag: Tag.h5,
          ),
          onTap: () {
            _showMoreEvents(context, details);
          },
        ),
      );
    } else if (_calendarController.view == CalendarView.month) {
      final Appointment appointment = details.appointments.first;
      return InkWell(
        child: Container(
            width: details.bounds.width,
            height: details.bounds.height,
            decoration: BoxDecoration(
              color: appointment.color,
              border: Border.all(color: InitialStyle.border),
              borderRadius: BorderRadius.circular(InitialDims.border1),
            ),
            alignment: Alignment.center,
            child: FxText(
              appointment.subject,
              color: InitialStyle.onPrimaryColor,
              tag: Tag.h6,
            )),
        onTap: () {
          setState(() {
            _date = details.date;
            _editController.text = details.appointments.first.subject;
          });

          _editEvent(context, details.appointments.first.id);
        },
      );
    } else {
      final Appointment appointment = details.appointments.first;
      return SizedBox(
        width: details.bounds.width,
        height: details.bounds.height,
        child: InkWell(
          child: FxText(
            appointment.subject,
            color: InitialStyle.onPrimaryColor,
            tag: Tag.h5,
          ),
          onTap: () {
            setState(() {
              _date = details.date;
              _editController.text = details.appointments.first.subject;
            });

            _editEvent(context, details.appointments.first.id);
          },
        ),
      );
    }
  }

  Widget _monthCellBuilder(BuildContext context, MonthCellDetails details) {
    return Container(
      decoration: BoxDecoration(
        color: (details.date.day == DateTime.now().day &&
                details.date.month == DateTime.now().month)
            ? InitialStyle.disableColorRegular
            : Colors.transparent,
        border: Border.all(
          color: InitialStyle.border,
        ),
      ),
      child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(InitialDims.space1),
            child: FxText(details.date.day.toString(),
                color: details.date.month == DateTime.now().month
                    ? InitialStyle.titleTextColor
                    : InitialStyle.textColor),
          )),
    );
  }

  _DataSource _getDataSource() {
    return _DataSource(_appointments);
  }

  Future<dynamic> _addEvent(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: FxText("Add event"),
          backgroundColor: InitialStyle.cardColor,
          actions: <Widget>[
            Column(
              children: [
                FxText("Please enter event name:"),
                const FxVSpacer(
                  big: true,
                ),
                FxTextField(
                  controller: _addController,
                ),
                const FxVSpacer(
                  big: true,
                ),
                FxEnglishDatePicker(
                  title: "Pick end date",
                  initialTime: _dateAdd,
                  onChange: (date) {
                    setState(() {
                      _dateAdd = date ?? _date;
                    });
                    Navigator.pop(context, date);
                  },
                ),
                const FxVSpacer(
                  big: true,
                ),
                FxButton(
                  text: "ok",
                  onTap: () {
                    setState(() {
                      _appointments.add(
                        Appointment(
                          startTime: _dateAdd,
                          endTime: _dateAdd.add(Duration(hours: 1)),
                          subject: _addController.text,
                        ),
                      );
                      _addController.text = "";
                    });

                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        );
      },
    ).then((val) {
      setState(() {
        if (val.runtimeType == DateTime.now().runtimeType) {
          _appointments.add(
            Appointment(
                startTime: _dateAdd,
                endTime: _dateAdd.add(Duration(hours: 1)),
                subject: _addController.text,
                color: InitialStyle.primaryColor),
          );
        }

        _addController.text = "";
      });
    });
  }

  Future<dynamic> _editEvent(BuildContext context, int id) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: FxText("Edit event"),
          backgroundColor: InitialStyle.cardColor,
          actions: <Widget>[
            Column(
              children: [
                FxText("Please edit event name:"),
                const FxVSpacer(
                  big: true,
                ),
                FxTextField(
                  controller: _editController,
                  maxLines: 7,
                ),
                const FxVSpacer(
                  big: true,
                ),
                FxEnglishDatePicker(
                  title: "Pick end date",
                  initialTime: _dateEdit,
                  onChange: (editDate) {
                    _appointments[_getAppointmentIndex(id)].subject =
                        _editController.text;
                    _appointments[_getAppointmentIndex(id)].startTime =
                        editDate ?? _date;
                    _appointments[_getAppointmentIndex(id)].endTime =
                        (editDate ?? _date).add(Duration(hours: 1));
                    Navigator.pop(context);
                  },
                ),
                const FxVSpacer(
                  big: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        _appointments
                            .remove(_appointments[_getAppointmentIndex(id)]);
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.delete,
                        color: InitialStyle.dangerColorRegular,
                      ),
                    ),
                    FxButton(
                      text: "ok",
                      onTap: () {
                        _appointments[_getAppointmentIndex(id)].subject =
                            _editController.text;
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ).then((val) {
      setState(() {
        _editController.text = "";
      });
    });
  }

  int _getAppointmentIndex(int id) {
    int appointmentIndex = 0;

    for (int i = 0; i < _appointments.length; i++) {
      if (_appointments[i].id == id) {
        appointmentIndex = i;
      }
    }
    return appointmentIndex;
  }

  Future<dynamic> _showMoreEvents(
      BuildContext context, CalendarAppointmentDetails details) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: InitialStyle.cardColor,
          actions: <Widget>[
            SizedBox(
              height: InitialDims.space25 * 4,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FxText(
                      "Events",
                      color: InitialStyle.titleTextColor,
                    ),
                    FxVSpacer(),
                    ...List.generate(details.appointments.length, (index) {
                      final Appointment appointment =
                          details.appointments.elementAt(index);
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: InitialDims.space2),
                        child: InkWell(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: InitialDims.space2),
                              alignment: Alignment.center,
                              height: InitialDims.space10,
                              decoration: BoxDecoration(
                                color: appointment.color,
                                borderRadius:
                                    BorderRadius.circular(InitialDims.border1),
                              ),
                              child: FxText(
                                appointment.subject,
                                color: InitialStyle.onPrimaryColor,
                                tag: Tag.h5,
                              )),
                          onTap: () {
                            setState(() {
                              _date = details.date;
                              _editController.text =
                                  details.appointments.first.subject;
                            });

                            _editEvent(context, details.appointments.first.id);
                          },
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}
