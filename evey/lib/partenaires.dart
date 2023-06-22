// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, library_private_types_in_public_api

import 'package:evey/data.dart';
import 'package:evey/partenaire.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Partenaires extends KFDrawerContent {
  @override
  _PartenairesState createState() => _PartenairesState();
}

class _PartenairesState extends State<Partenaires> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Partenaires',
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
                  if (snapshot.hasData == false) {
                    //while getting the data of our event, the screen is loading
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
                          //we display here the list of the sponsors in our event
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ...snapshot.data!.sponsors.map((partenaire) {
                              //we need this line to prevent null safety problems
                              if (partenaire.logo == null) return Container();
                              //here is the zone of each sponsor
                              return GestureDetector(
                                child: Container(
                                  height: 114,
                                  width: double.infinity,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        //here is the logo of the sponsor
                                        height: 70,
                                        width: 90,
                                        color: Colors.transparent,
                                        child: Image.network(
                                            partenaire.logo!.url
                                                    .startsWith('https')
                                                ? partenaire.logo!.url
                                                : 'https://backstage.conference.evey.live${partenaire.logo!.url}',
                                            height: 114,
                                            fit: BoxFit.fill),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        //here is the name of the company
                                        partenaire.name,
                                        style: const TextStyle(
                                          color: Color(0xFF1f3f84),
                                          fontSize: 22,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  //clicking on the sponsor his description page appear
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Partenaire(
                                        name: partenaire.name,
                                        facebook: '',
                                        instagram: '',
                                        twitter: '',
                                        email: '',
                                        web: partenaire.website,
                                        bio: partenaire.description == null
                                            ? ''
                                            : htmlToString(
                                                    partenaire.description)
                                                .trim(),
                                        logo: partenaire.logo!.url
                                                .startsWith('https')
                                            ? partenaire.logo!.url
                                            : 'https://backstage.conference.evey.live${partenaire.logo!.url}',
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
