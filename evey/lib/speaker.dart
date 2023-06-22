// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

//this variable represent the name of the speaker
var this_name;
//this variable represent his job
var job;
//this variable represent his company
var entreprise;
//this variable represent his description
var biographie;
//this variable represent the link to his linkedin account
var link_in;
//this variable represent his email
var mail;
//this variable represent his phone number
var num;
//this variable represent the link to his picture
var pic;

class Speakerr extends StatefulWidget {
  Speakerr({
    super.key,
    name,
    poste,
    societe,
    bio,
    linkedin,
    email,
    phone,
    image,
  }) {
    this_name = name;
    job = poste;
    entreprise = societe;
    biographie = bio;
    link_in = linkedin;
    mail = email;
    num = phone;
    pic = image;
  }

  @override
  State<Speakerr> createState() => _SpeakerrState();
}

class _SpeakerrState extends State<Speakerr> {
  //this widget will help us acces the social media pages of the speaker
  Widget media({icon, link, color}) {
    return IconButton(
      //clicking on it will lead us outside the app to the social media page
      onPressed: () {
        launchUrlString(link, mode: LaunchMode.externalNonBrowserApplication);
      },
      icon: Icon(
        //here is the icon representing the social media
        icon,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          //this button will take us back to the list of speakers
          onPressed: () {
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
                //here we find the pic of the speaker
                margin: const EdgeInsets.symmetric(vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 25),
                height: 200,
                width: 200,
                child: CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: Image.network(pic, width: 200, fit: BoxFit.fill),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //we display then his name
                  Text(
                    this_name,
                    style: const TextStyle(
                      color: Color(0xFF1f3f84),
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  //we write here his position and his company
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '$job, $entreprise',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF4c6c9c),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    //we found here all his social media accounts
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      media(
                        color: const Color(0xFF0A66C2),
                        icon: FontAwesomeIcons.linkedin,
                        link: link_in,
                      ),
                      media(
                        color: const Color(0xFFFF0000),
                        icon: FontAwesomeIcons.envelope,
                        link: mail,
                      ),
                      media(
                        color: const Color(0xFF4CB37A),
                        icon: FontAwesomeIcons.phone,
                        link: num,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                //here is his description
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Text(
                  biographie,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
