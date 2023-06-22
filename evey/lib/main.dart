// ignore_for_file: library_private_types_in_public_api

import 'package:evey/connecter.dart';
import 'package:evey/data.dart';
import 'package:evey/inscrire.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: <Widget>[
              FutureBuilder<Event>(
                future: event,
                builder: (context, snapshot) {
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Center(
                          child: Text(
                            'Bienvenue',
                            style: TextStyle(
                              color: Color(0xFF1f3f84),
                              fontSize: 64,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28.0, vertical: 5.0),
                            child: Text(
                              snapshot.data!.locationText,
                              style: const TextStyle(
                                color: Color(0xFF1f3f84),
                                fontSize: 17,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 28.0, right: 28.0, bottom: 20.0),
                            child: Text(
                              snapshot.data!.title,
                              style: const TextStyle(
                                color: Color(0xFF4c6c9c),
                                fontSize: 23,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Image.network(
                            snapshot.data!.logoLeft.url,
                            width: 272,
                            height: 272,
                            fit: BoxFit.contain,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Connecter()));
                          },
                          minWidth: 335,
                          height: 67,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                              width: 5,
                              color: Color(0xFF4c6c9c),
                            ),
                          ),
                          elevation: 0,
                          highlightElevation: 0,
                          child: const Text(
                            "Connecter",
                            style: TextStyle(
                              color: Color(0xFF4c6c9c),
                              fontSize: 36,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Inscrire()));
                          },
                          minWidth: 335,
                          height: 67,
                          color: const Color(0xFF1f3f84),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                          highlightElevation: 0,
                          child: const Text(
                            "S'inscrire",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
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
