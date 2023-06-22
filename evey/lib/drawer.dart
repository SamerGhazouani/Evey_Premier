// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:evey/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:evey/accueil.dart';
import 'package:evey/informations.dart';
import 'package:evey/programme.dart';
import 'package:evey/speakers.dart';
import 'package:evey/partenaires.dart';
import 'package:evey/quiz.dart';
import 'package:evey/direct.dart';

//this variable is used to store the current page
var initPage;

class MyDrawer extends StatefulWidget {
  //the drawer is each time associated to the current page
  MyDrawer(page, {super.key}) {
    initPage = page;
  }
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  late KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: initPage,
      //in here we list the links to the different interfaces of our app. Each one have a title and an icon
      items: [
        KFDrawerItem.initWithPage(
          text: const Text(
            'Accueil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: const Icon(
              IconData(
                0xf107,
                fontFamily: 'MaterialIcons',
              ),
              color: Colors.white),
          page: Accueil(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text(
            'Informations',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: const Icon(Icons.info_outline_rounded, color: Colors.white),
          page: Informations(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text(
            'Programme',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: const Icon(Icons.calendar_month_rounded, color: Colors.white),
          page: Programme(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text(
            'Speakers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: const Icon(Icons.mic_none_rounded, color: Colors.white),
          page: Speakers(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text(
            'Partenaires',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: const Icon(Icons.business_center_outlined, color: Colors.white),
          page: Partenaires(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text(
            'Direct',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: const Icon(Icons.live_tv_rounded, color: Colors.white),
          page: Direct(),
        ),
        KFDrawerItem.initWithPage(
          text: const Text(
            'Quiz',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          icon: const Icon(Icons.quiz_outlined, color: Colors.white),
          page: Quiz(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String username =
        FirebaseAuth.instance.currentUser?.displayName ?? "erreur";
    return Scaffold(
      body: KFDrawer(
        controller: _drawerController,
        header: Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Bienvenue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  //we welcome here the user by displaying his displayName
                  username,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
        footer: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            KFDrawerItem(
              //this is the disconnect button
              text: const Text(
                'Déconnecter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                //after pressing it the user sign out and return to the home page
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
          ],
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF1f3f84),
        ),
      ),
    );
  }
}
