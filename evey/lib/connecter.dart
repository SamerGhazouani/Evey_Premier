// ignore_for_file: use_build_context_synchronously

import 'package:evey/accueil.dart';
import 'package:evey/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evey/inscrire.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Connecter extends StatefulWidget {
  const Connecter({super.key});
  @override
  State<Connecter> createState() => _ConnecterState();
}

class _ConnecterState extends State<Connecter> {
  //those are the variables that will stock what we write in the forum
  final _email = TextEditingController();
  final _password = TextEditingController();
  //this is the variable used to show the exceptions
  String _error = "";
  //this variable is used for the eye icon to show or obscure the password written
  bool visible = true;
  // this variable is used for the loading animation while authenticating
  var loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bienvenue',
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
            //clicking on this button will take us back to the home page and delete the content on every field
            _email.clear();
            _password.clear();
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
              //if we are logging in a loading screen will appear, if not the forum is displayed
              loading
                  ? Column(
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
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: const <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Connecter',
                              style: TextStyle(
                                color: Color(0xFF1f3f84),
                                fontSize: 40,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Connectez-vous à votre compte',
                              style: TextStyle(
                                color: Color(0xFF4c6c9c),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 27),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //we find here our forum
                              const Text(
                                'Email :',
                                style: TextStyle(
                                  color: Color(0xFF1f3f84),
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                //the controller is the responsible for stocking the data written
                                controller: _email,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF4c6c9c),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF4c6c9c),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Mot de passe :',
                                style: TextStyle(
                                  color: Color(0xFF1f3f84),
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextField(
                                controller: _password,
                                //if visible is true the text is shown else it's hidden
                                obscureText: visible,
                                keyboardType: TextInputType.visiblePassword,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF4c6c9c),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xFF4c6c9c),
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      //if visible is true the icon is an open eye else it's a closed eye
                                      visible
                                          ? Icons.visibility_off_rounded
                                          : Icons.visibility_rounded,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          //clicking on the icon the value of visible will change either true or false
                                          visible = !visible;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            setState(
                              () {
                                //after clicking on it the screen start loading
                                loading = true;
                              },
                            );
                            //logging in
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: _email.text,
                                    password: _password.text)
                                .then(
                              (value) {
                                //if the account exist, we get access to the app. We remove also the text from every field
                                _email.clear();
                                _password.clear();
                                _error = "";
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyDrawer(Accueil()),
                                  ),
                                );
                              },
                            ).onError(
                              (e, stackTrace) {
                                //if something wrong happens while logging in we write an error
                                _error = e
                                    .toString()
                                    .substring(e.toString().indexOf(']') + 2);
                              },
                            );
                            //if there is an error we displayed to the user here
                            if (_error.isNotEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    _error,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            }
                            setState(
                              () {
                                //after the operation is done we set the value of loading back to false so that if an error happens the forum appears again
                                loading = false;
                              },
                            );
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
                            'Connecter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              "N'avez pas de compte ?",
                              style: TextStyle(
                                color: Color(0xFF4c6c9c),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              //this button will take us to the inscription page
                              onPressed: () {
                                _email.clear();
                                _password.clear();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Inscrire(),
                                  ),
                                );
                              },
                              child: const Text(
                                "S'inscrire",
                                style: TextStyle(
                                  color: Color(0xFF4c6c9c),
                                  fontSize: 15,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          height: 233,
                          width: 347,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/login.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
