// ignore_for_file: non_constant_identifier_names, use_key_in_widget_constructors, must_be_immutable, library_private_types_in_public_api

import 'package:evey/session.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:intl/intl.dart';
import 'package:evey/data.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//this variable is used to navigate between the selected dates
var date_now = DateFormat().add_yMMMd().format(DateTime(2022, 5, 21));
//this variables is representing the stage number in the JSON file so we know on which date are we
var stage_num = 0;
//this variable is used to keep the last date selected
var selected = DateTime(2022, 5, 21);

class Programme extends KFDrawerContent {
  @override
  _ProgrammeState createState() => _ProgrammeState();
}

class _ProgrammeState extends State<Programme> {
  //we created this widget to display the different sessions on each day
  Widget session_box(
      {number, start_date, end_date, name, description, speakers, stream}) {
    //this function is used to change colors between sessions
    Color verif(int number) {
      return number % 2 != 0
          ? const Color(0xFF737474)
          : const Color(0xFF4c6c9c);
    }

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: verif(number),
        ),
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              //we write first the name of the session
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            //we display here the hours of the session
            Row(
              children: <Widget>[
                const Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 12,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '${DateFormat().add_Hm().format(start_date)} - ${DateFormat().add_Hm().format(end_date)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            //if there are speakers associated to this session their profile pics will be displayed in the footer of the box
            Row(
              children: [
                ...speakers.map((img) {
                  return Container(
                    height: 18,
                    width: 18,
                    margin: const EdgeInsets.only(right: 5),
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(img.image),
                    ),
                  );
                }).toList()
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        //clicking on the box we access the page containing the description of the session
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Session(
              number: number,
              start_date: start_date,
              end_date: end_date,
              name: name,
              description: description,
              speakers: speakers,
              stream: stream,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Programme',
          style: TextStyle(
            color: Color(0xFF4c6c9c),
            fontSize: 24,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          //this button will open our drawer
          onPressed: widget.onMenuPressed,
          icon: const Icon(
            Icons.menu_rounded,
            size: 30,
            color: Color(0xFF4c6c9c),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: ListView(
            children: <Widget>[
              FutureBuilder(
                future: event,
                builder: (context, snapshot) {
                  //while getting the data of our event, the screen is loading
                  if (snapshot.hasData == false) {
                    return Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 220,
                        ),
                        Center(
                          child: LoadingAnimationWidget.beat(
                            color: const Color(0xFF1f3f84),
                            size: 200,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: <Widget>[
                        //we first get the dates of our event
                        Container(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 80,
                          ),
                          child: DatePicker(
                            //here we choose the initial date
                            snapshot.data!.date,
                            height: 85,
                            width: 72,
                            initialSelectedDate: selected,
                            activeDates: [
                              //here is the list of dates
                              snapshot.data!.date,
                              snapshot.data!.date.add(
                                const Duration(days: 1),
                              ),
                            ],
                            selectionColor: const Color(0xFF1f3f84),
                            selectedTextColor: Colors.white,
                            dateTextStyle: const TextStyle(
                              color: Color(0xFF1f3f84),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                            dayTextStyle: const TextStyle(
                              color: Color(0xFF1f3f84),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                            monthTextStyle: const TextStyle(
                              color: Color(0xFF1f3f84),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                            deactivatedColor: Colors.grey,
                            locale: "fr_FR",
                            daysCount: 8,
                            onDateChange: (selectedDate) {
                              //when we change the date the variables date_now and stage_num also changes to display the correspondent sessions
                              setState(() {
                                //we change also the value of selected so when we change the page and then go back to program we found the last date that we selected
                                selected = selectedDate;
                                date_now = DateFormat()
                                    .add_yMMMd()
                                    .format(selectedDate);
                                DateFormat()
                                            .add_yMMMd()
                                            .format(selectedDate)
                                            .compareTo(DateFormat()
                                                .add_yMMMd()
                                                .format(snapshot.data!.date)) ==
                                        0
                                    ? stage_num = 0
                                    : stage_num = 1;
                              });
                            },
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            //we display here the list of sessions by choosing which stage
                            ...snapshot.data!.stages[stage_num].schedule
                                .map((val) {
                              return session_box(
                                  number: val.id,
                                  start_date: val.start,
                                  end_date: val.end,
                                  name: val.title,
                                  description: val.description == null
                                      ? ''
                                      : htmlToString(val.description).trim(),
                                  stream:
                                      snapshot.data!.stages[stage_num].stream,
                                  speakers: val.speakers);
                            }).toList(),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
