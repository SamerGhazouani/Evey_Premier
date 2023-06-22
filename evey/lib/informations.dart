// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:evey/data.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Informations extends KFDrawerContent {
  @override
  _InformationsState createState() => _InformationsState();
}

class _InformationsState extends State<Informations> {
  //we created this widget to display the box containing the date ot the place
  Widget box({label, icon}) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF1B232A)),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFFe7e7e9),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //here is the icon of an agenda or a place
          Icon(
            icon,
            size: 71,
            color: const Color(0xFF1f3f84),
          ),
          const SizedBox(
            height: 10,
          ),
          //here is the date or the place's name
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF1B232A),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  //this widget will help us acces the social media page of the event
  Widget media({icon, link, color}) {
    return IconButton(
      //pressing on the button will lead us to the external app
      onPressed: () {
        launchUrlString(link, mode: LaunchMode.externalNonBrowserApplication);
      },
      //this is the icon of the social media selected
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Informations',
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
                              vertical: 30, horizontal: 70),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            //we load here the description of the event and convert it from a html form to a string and removing additional data
                            Text(
                              htmlToString(snapshot.data!.aboutText)
                                  .substring(
                                    0,
                                    htmlToString(snapshot.data!.aboutText)
                                        .indexOf('.'),
                                  )
                                  .trim(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                //here is the date of the event
                                box(
                                    label: snapshot.data!.locationText
                                        .substring(
                                          0,
                                          snapshot.data!.locationText
                                              .indexOf('|'),
                                        )
                                        .trim(),
                                    icon: Icons.calendar_month_rounded),
                                //here is the location of the event
                                box(
                                    label: snapshot.data!.locationText
                                        .substring(
                                          snapshot.data!.locationText
                                                  .indexOf('|') +
                                              1,
                                        )
                                        .trim(),
                                    icon: Icons.place),
                              ],
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            const Text(
                              'Vous pouvez nous contacter ici :',
                              style: TextStyle(
                                color: Color(0xFF1B232A),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              //we found here different social media links related to our event
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                media(
                                  color: const Color(0xFF4267B2),
                                  icon: FontAwesomeIcons.facebook,
                                  link:
                                      'https://www.facebook.com/samer.ghazouani.69420',
                                ),
                                media(
                                  color: const Color(0xFFFB3958),
                                  icon: FontAwesomeIcons.instagram,
                                  link:
                                      'https://www.instagram.com/samer_ghazouani/',
                                ),
                                media(
                                  color: const Color(0xFF1DA1F2),
                                  icon: FontAwesomeIcons.twitter,
                                  link:
                                      'https://www.twitter.com/ghazouani_samer',
                                ),
                                media(
                                  color: const Color(0xFFFF0000),
                                  icon: FontAwesomeIcons.envelope,
                                  link: 'mailto: fake.event@gmail.com',
                                ),
                                media(
                                  color: const Color(0xFF4CB37A),
                                  icon: FontAwesomeIcons.phone,
                                  link: 'tel: +216 28000000',
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
