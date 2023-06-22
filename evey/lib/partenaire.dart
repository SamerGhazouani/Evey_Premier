// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

//this variable represents the name of the sponsor
var this_name;
// this variable represents the link to the facebook page of the sponsor
var fb;
// this variable represents the link to the instagram page of the sponsor
var insta;
// this variable represents the link to the twitter page of the sponsor
var tweet;
// this variable represents the email of the sponsor
var mail;
// this variable represents the link to the website of the sponsor
var site;
//this variable represents the description of the sponsor
var biographie;
// this variable represents the link to the logo of the sponsor
var image;

class Partenaire extends StatefulWidget {
  Partenaire({
    super.key,
    name,
    facebook,
    instagram,
    twitter,
    email,
    web,
    bio,
    logo,
  }) {
    this_name = name;
    fb = facebook;
    insta = instagram;
    tweet = twitter;
    mail = email;
    site = web;
    biographie = bio;
    image = logo;
  }

  @override
  State<Partenaire> createState() => _PartenaireState();
}

class _PartenaireState extends State<Partenaire> {
  //this widget will help us acces the social media pages of the sponsor
  Widget media({icon, link, color}) {
    return IconButton(
      onPressed: () {
        //clicking on it will lead us outside the app to the social media page
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
          onPressed: () {
            //this button will take us back to the list of sponsors
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
              const SizedBox(
                height: 20,
              ),
              Container(
                //here we find the logo of the sponsor
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 150,
                color: Colors.transparent,
                child: Image.network(image, fit: BoxFit.fill),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    //we display then the name of the company
                    this_name,
                    style: const TextStyle(
                      color: Color(0xFF1f3f84),
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    //we found here all the social media accounts and website related to the sponsor
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      media(
                        color: const Color(0xFF4267B2),
                        icon: FontAwesomeIcons.facebook,
                        link: fb,
                      ),
                      media(
                        color: const Color(0xFFFB3958),
                        icon: FontAwesomeIcons.instagram,
                        link: insta,
                      ),
                      media(
                        color: const Color(0xFF1DA1F2),
                        icon: FontAwesomeIcons.twitter,
                        link: tweet,
                      ),
                      media(
                        color: const Color(0xFFFF0000),
                        icon: FontAwesomeIcons.envelope,
                        link: mail,
                      ),
                      media(
                        color: Colors.blueAccent,
                        icon: FontAwesomeIcons.globe,
                        link: site,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Text(
                  //here is the description of the company
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
