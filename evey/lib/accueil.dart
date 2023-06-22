// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, library_private_types_in_public_api

import 'package:evey/direct.dart';
import 'package:evey/partenaires.dart';
import 'package:evey/programme.dart';
import 'package:evey/quiz.dart';
import 'package:evey/speakers.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:evey/informations.dart';
import 'package:evey/drawer.dart';
import 'package:evey/data.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Accueil extends KFDrawerContent {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  //we created this widget to design the button that leads us to every page
  Widget shortcut({label, icon, goTo}) {
    return GestureDetector(
      child: Container(
        height: 130,
        width: 130,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF1B232A)),
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFe7e7e9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              //here is the icon representing the page
              icon,
              size: 71,
              color: const Color(0xFF1f3f84),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              // here is the title of the page
              label,
              style: const TextStyle(
                color: Color(0xFF1B232A),
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        //clicking on it will lead us to the corespondent page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyDrawer(goTo)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Accueil',
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
              FutureBuilder<Event>(
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 70,
                          ),
                          color: Colors.white,
                          //we load here the logo of the event
                          child: Image.network(
                            snapshot.data!.logoLeft.url,
                            height: 150,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Column(
                          //now we display the different links to the pages
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                shortcut(
                                  label: 'Informations',
                                  icon: Icons.info_rounded,
                                  goTo: Informations(),
                                ),
                                shortcut(
                                  label: 'Programme',
                                  icon: Icons.calendar_today_rounded,
                                  goTo: Programme(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                shortcut(
                                  label: 'Speakers',
                                  icon: Icons.mic,
                                  goTo: Speakers(),
                                ),
                                shortcut(
                                  label: 'Partenaires',
                                  icon: Icons.business_center,
                                  goTo: Partenaires(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                shortcut(
                                  label: 'Direct',
                                  icon: Icons.podcasts_outlined,
                                  goTo: Direct(),
                                ),
                                shortcut(
                                  label: 'Quiz',
                                  icon: Icons.quiz_rounded,
                                  goTo: Quiz(),
                                ),
                              ],
                            ),
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
