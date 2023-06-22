// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:evey/speaker.dart';
import 'package:evey/data.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Speakers extends KFDrawerContent {
  @override
  _SpeakersState createState() => _SpeakersState();
}

class _SpeakersState extends State<Speakers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Speakers',
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
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          //we display here the list of the speakers in our event
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ...snapshot.data!.speakers.map((speaker) {
                              return GestureDetector(
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      //we first load their profile pic
                                      CircleAvatar(
                                        radius: 48,
                                        backgroundImage:
                                            NetworkImage(speaker.image.url),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            //then show their name
                                            Text(
                                              speaker.name,
                                              style: const TextStyle(
                                                color: Color(0xFF1f3f84),
                                                fontSize: 22,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              //we display here their job
                                              speaker.title,
                                              style: const TextStyle(
                                                color: Color(0xFF1B232A),
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              //and here their company
                                              speaker.company,
                                              style: const TextStyle(
                                                color: Color(0xFF4c6c9c),
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  //clicking on the speaker his description page appear
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Speakerr(
                                        name: speaker.name,
                                        poste: speaker.title,
                                        societe: speaker.company,
                                        bio: speaker.bio == null
                                            ? ''
                                            : htmlToString(speaker.bio).trim(),
                                        linkedin: 'https://www.linkedin.com',
                                        email: speaker.email ?? '',
                                        phone: 'tel: +216 28000000',
                                        image: speaker.image.url,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList()
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
