// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, library_private_types_in_public_api, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:evey/data.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class Quiz extends KFDrawerContent {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  //we created this widget to represent the button that clicking on it will take us to the quiz
  Widget quiz_button(String title, String link) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF1f3f84),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Text(
          //here is the title of the quiz
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () {
        //clicking on it will take us to quiz in the browser
        launchUrl(
          Uri.parse(
            link.substring(
              link.indexOf("src") + 5,
              link.indexOf("width") - 2,
            ),
          ),
          mode: LaunchMode.externalApplication,
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
          'Quiz',
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
                      //these variables will stock the links to the different quizzes
                      var quiz1;
                      var quiz2;
                      snapshot.data!.stages[2].mainContent == null
                          ? quiz1 = ''
                          : quiz1 = snapshot.data!.stages[2].mainContent;
                      snapshot.data!.stages[3].mainContent == null
                          ? quiz2 = ''
                          : quiz2 = snapshot.data!.stages[3].mainContent;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 30),
                            height: 300,
                            width: 300,
                            child: Column(
                              //we display here our buttons
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                quiz_button(
                                    snapshot.data!.stages[2].name, quiz1),
                                quiz_button(
                                    snapshot.data!.stages[3].name, quiz2),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
