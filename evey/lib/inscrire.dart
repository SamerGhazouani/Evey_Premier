// ignore_for_file: use_build_context_synchronously

import 'package:evey/accueil.dart';
import 'package:evey/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evey/connecter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

//those are the variables that will stock what we write in the forum
var _nom = TextEditingController();
var _prenom = TextEditingController();
var _email = TextEditingController();
var _password = TextEditingController();
//this is the variable used to show the exceptions
String _error = "";
// this variable is used for the loading animation while creating the account
var loading = false;
//this variable is used to check if the username is typed or not
String username = "";

class Inscrire extends StatefulWidget {
  const Inscrire({super.key});
  @override
  State<Inscrire> createState() => _InscrireState();
}

class _InscrireState extends State<Inscrire> {
  //this variable is used for the eye icon to show or obscure the password written
  bool visible = true;

  //this is the widget used to create every field of the forum except the password
  Widget field({label, keyboard = TextInputType.name, text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          //we write here the name of the field
          label,
          style: const TextStyle(
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
          controller: text,
          //we precises here the type of keyboard we want. It can be a normal text, number, email...
          keyboardType: keyboard,
          decoration: InputDecoration(
            hintText: '',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            Navigator.pop(context);
            _nom.clear();
            _prenom.clear();
            _email.clear();
            _password.clear();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 22,
            color: Color(0xFF4c6c9c),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            //if we are creating an account a loading screen will appear, if not the forum is displayed
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
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 29),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: const <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "S'inscrire",
                              style: TextStyle(
                                color: Color(0xFF1f3f84),
                                fontSize: 40,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'Créer un nouveau compte',
                              style: TextStyle(
                                color: Color(0xFF4c6c9c),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                        Column(
                          //we find here our forum
                          children: <Widget>[
                            field(
                              label: 'Nom :',
                              text: _nom,
                            ),
                            field(
                              label: 'Prénom :',
                              text: _prenom,
                            ),
                            field(
                              label: 'Email :',
                              keyboard: TextInputType.emailAddress,
                              text: _email,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
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
                                  //if visible is true the text is shown else it's hidden
                                  obscureText: visible,
                                  controller: _password,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 10,
                                    ),
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
                                const SizedBox(
                                  height: 38,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            MaterialButton(
                              //this is the inscription button
                              onPressed: () async {
                                setState(
                                  () {
                                    //after clicking on it the screen start loading
                                    loading = true;
                                  },
                                );
                                //check if one of the fields is empty
                                if (_prenom.text.isEmpty || _nom.text.isEmpty) {
                                  username = "";
                                } else {
                                  username = "${_prenom.text} ${_nom.text}";
                                }
                                //creating the account based on email and password only
                                await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _email.text,
                                        password: _password.text)
                                    .then(
                                  (value) async {
                                    //adding the username
                                    await value.user
                                        ?.updateDisplayName(username)
                                        .then(
                                      (value) {
                                        if (username.isNotEmpty) {
                                          //if the username is written the account is created and we access the app. We remove also the text from every field
                                          _error = "";
                                          _nom.clear();
                                          _prenom.clear();
                                          _email.clear();
                                          _password.clear();
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyDrawer(Accueil()),
                                            ),
                                          );
                                        } else {
                                          //if one of the fields is empty we cancel the creation of the account and we write an error
                                          _error = "Empty Field";
                                          FirebaseAuth.instance.currentUser
                                              ?.delete();
                                        }
                                      },
                                    );
                                  },
                                ).onError(
                                  (e, stackTrace) {
                                    //if something wrong happens while creating the account we write an error
                                    _error = e.toString().substring(
                                        e.toString().indexOf(']') + 2);
                                  },
                                );
                                //if there is an error we displayed to the user here
                                if (_error.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 2),
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
                                "S'inscrire",
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
                                  "Vous avez déjà un compte?",
                                  style: TextStyle(
                                    color: Color(0xFF4c6c9c),
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextButton(
                                  //this button will take us to the connection page
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Connecter(),
                                      ),
                                    );
                                    _nom.clear();
                                    _prenom.clear();
                                    _email.clear();
                                    _password.clear();
                                  },
                                  child: const Text(
                                    "Connecter",
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
                          ],
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
