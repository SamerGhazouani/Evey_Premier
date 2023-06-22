// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:evey/direct.dart';
import 'package:evey/drawer.dart';
import 'package:evey/speaker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

//this variable will determine the order of the session
var num;
//this variable represents the hour of the start of the session
var start;
//this variable represents the hour of the end of the session
var end;
//this variable represents the title of the session
var title;
//this variable represents the description of the session
var about;
//this variable represents the list of speakers of the session
var speakers_list;
//this variable represents the link to the live stream of the session
var live;

class Session extends StatefulWidget {
  Session(
      {super.key,
      number,
      start_date,
      end_date,
      name,
      description,
      speakers,
      stream}) {
    num = number;
    start = start_date;
    end = end_date;
    title = name;
    about = description;
    speakers_list = speakers;
    live = stream;
  }

  @override
  State<Session> createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: () {
            //this button will take us back to the schedule
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
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
              Container(
                padding: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      //we display here the title of the session
                      title,
                      style: const TextStyle(
                        color: Color(0xFF1f3f84),
                        fontSize: 25,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Row(
                      //here we will present the date and the hour of the session
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: Color(0xFF1f3f84),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat('dd/MM/yyyy').format(start),
                          style: const TextStyle(
                            color: Color(0xFF4c6c9c),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        const Icon(
                          Icons.access_time_filled,
                          size: 18,
                          color: Color(0xFF1f3f84),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${DateFormat().add_Hm().format(start)} - ${DateFormat().add_Hm().format(end)}',
                          style: const TextStyle(
                            color: Color(0xFF4c6c9c),
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      //here we will put the description
                      about,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Speakers',
                      style: TextStyle(
                        color: Color(0xFF1f3f84),
                        fontSize: 25,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Column(
                      //if there are speakers associated to this session they will be displayed here with their name, pic, job and company
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ...speakers_list.map(
                          (speaker) {
                            return GestureDetector(
                              child: Container(
                                height: 114,
                                width: double.infinity,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 48,
                                      backgroundImage:
                                          NetworkImage(speaker.image),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          speaker.name,
                                          style: const TextStyle(
                                            color: Color(0xFF4c6c9c),
                                            fontSize: 36,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Text(
                                          speaker.poste,
                                          style: const TextStyle(
                                            color: Color(0xFF4c6c9c),
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          speaker.societe,
                                          style: const TextStyle(
                                            color: Color(0xFF4c6c9c),
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                //clicking on a speaker a page containing his description will appear
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Speakerr(
                                      name: speaker.name,
                                      poste: speaker.poste,
                                      societe: speaker.societe,
                                      bio: speaker.bio,
                                      linkedin: speaker.linkedin,
                                      email: speaker.email,
                                      phone: speaker.phone,
                                      image: speaker.image,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ).toList()
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MaterialButton(
                          //this button will lead us to youtube if the session is finished or to the stream page if it's still going
                          onPressed: () {
                            //we check first the availability of the session
                            /*if (DateTime.now().isAfter(start) &&
                                DateTime.now().isBefore(end))*/
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyDrawer(Direct()),
                              ),
                            );
                            /*else
                              launchUrl(
                                  Uri.parse(
                                      'https://www.youtube.com/live/' + live),
                                  mode:
                                      LaunchMode.externalNonBrowserApplication);*/
                          },
                          minWidth: 154,
                          height: 56,
                          color: const Color(0xFF1f3f84),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                          highlightElevation: 0,
                          child: const Text(
                            'Regarder',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        MaterialButton(
                          //this button will lead us to the conference if the session is still going or will display an error message
                          onPressed: () async {
                            //we check first the availability of the session
                            /*if (DateTime.now().isAfter(start) &&
                                DateTime.now().isBefore(end))*/
                            launchUrl(Uri.parse('https://vc.evey.live/test'),
                                mode: LaunchMode.externalApplication);
                            /*else
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'Conférence Terminée',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );*/
                          },
                          minWidth: 154,
                          height: 56,
                          color: const Color(0xFF1f3f84),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                          highlightElevation: 0,
                          child: const Text(
                            'Rejoindre',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
