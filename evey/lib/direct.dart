// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, use_key_in_widget_constructors, must_be_immutable, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'package:evey/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//this variable represents the controller stocking the text we typed
var myController = TextEditingController();
//here we connect with our database where we're going to stock the conversation
FirebaseDatabase _database = FirebaseDatabase.instanceFor(
  app: Firebase.app(),
  databaseURL: 'https://evey-00-default-rtdb.europe-west1.firebasedatabase.app',
);
//here is the variable stocking the conversation
DatabaseReference _messagesRef = _database.ref().child('messages');
//this controller will help us scroll the conversation
ScrollController list_controller = ScrollController();
//this variable will precise if the chat zone show the last message sended or not
var pos;
//this variable will count the number of messages in the conversation
int i = 0;

class Direct extends KFDrawerContent {
  @override
  _DirectState createState() => _DirectState();
}

class _DirectState extends State<Direct> {
  @override
  void initState() {
    super.initState();
    //when we open our page the last message sent is not shown
    pos = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Direct',
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
                    //we declare her the controller of the stream
                    var _controller = YoutubePlayerController(
                      //we load the ID of the stream
                      initialVideoId: snapshot.data!.stages[0].stream ?? '',
                      flags: const YoutubePlayerFlags(
                        //we precise that it's a live stream not a video
                        isLive: true,
                        //We don't show the full screen button cause it's going to bug it
                        showLiveFullscreenButton: false,
                      ),
                    );
                    //we're using the orientation builder not the normal one cause we're going to try to fix the full screen problem by turning the phone on landscape mode
                    return OrientationBuilder(
                      builder: (context, orientation) {
                        return Column(
                          children: <Widget>[
                            const SizedBox(
                              height: 20,
                            ),
                            //this is the container holding our player
                            Container(
                              //on portrait mode the width of the player will take the same width of the screen
                              width: MediaQuery.of(context).orientation ==
                                      Orientation.landscape
                                  ? null
                                  : MediaQuery.of(context).size.width,
                              //on landscape mode the height of the player will take "the height of the screen-110" to make the video approximately on full screen
                              height: MediaQuery.of(context).orientation ==
                                      Orientation.landscape
                                  ? MediaQuery.of(context).size.height - 110
                                  : null,
                              color: Colors.black,
                              child: YoutubePlayer(
                                //the player will play the stream that we put in the controller
                                controller: _controller,
                                //we will show the progress bar of the video
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.red,
                                progressColors: const ProgressBarColors(
                                  playedColor: Colors.red,
                                  handleColor: Colors.redAccent,
                                ),
                                onReady: () {
                                  //after the player is ready, it will start playing the live stream
                                  _controller.addListener(() {});
                                },
                              ),
                            ),
                            Container(
                              //this container represents our chat zone
                              height: 400,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 20,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFF4c6c9c)),
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFe7e7e9),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    //we first display the title "Chat"
                                    'Chat :',
                                    style: TextStyle(
                                      color: Color(0xFF1f3f84),
                                      fontSize: 23,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    //now we will show the messages
                                    child: StreamBuilder(
                                      stream: _messagesRef.onValue,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          //we will first load the conversation stocked in the database
                                          DataSnapshot dataSnapshot =
                                              snapshot.data!.snapshot;
                                          //we check if the data loaded is not null on its type is a dynamic map
                                          if (dataSnapshot.value != null) {
                                            Map<String, dynamic> messages = {};
                                            if (dataSnapshot.value
                                                is Map<dynamic, dynamic>) {
                                              Map<dynamic, dynamic> dynamicMap =
                                                  dataSnapshot.value
                                                      as Map<dynamic, dynamic>;
                                              //we put the data loaded inside the variable "messages"
                                              dynamicMap.forEach((key, value) {
                                                if (value
                                                    is Map<dynamic, dynamic>) {
                                                  Map<String, dynamic> message =
                                                      value.cast<String,
                                                          dynamic>();

                                                  messages[key.toString()] =
                                                      message;
                                                }
                                              });
                                            }
                                            //we sort the messages depending on the time they were sent
                                            List<MapEntry<String, dynamic>>
                                                sortedMessages =
                                                messages.entries.toList()
                                                  ..sort(
                                                    (a, b) => a
                                                        .value['timestamp']
                                                        .compareTo(
                                                      b.value['timestamp'],
                                                    ),
                                                  );
                                            //now we start displaying the conversation
                                            return ListView.builder(
                                              //we put first a controller for scrolling through the messages
                                              controller: list_controller,
                                              itemCount: sortedMessages.length,
                                              itemBuilder: (context, index) {
                                                //i will take the number of messages in the conversation
                                                i = sortedMessages.length;
                                                //we access each message separately
                                                Map<String, dynamic> message =
                                                    sortedMessages[index].value;
                                                //a variable will stock the name of the sender and the other will stock the message
                                                String sender =
                                                    message['sender'];
                                                String content =
                                                    message['content'];
                                                //we will display each message separately
                                                return Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      //first we will show the sender name
                                                      sender.isEmpty
                                                          ? sender
                                                          : '$sender :',
                                                      style: const TextStyle(
                                                        color:
                                                            Color(0xFF1f3f84),
                                                        fontSize: 13,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Expanded(
                                                      //we use expanded so that if a message is too long it will not show an error
                                                      child: Column(
                                                        //the column is used so that the first part of the message will be exactly next to the sender name
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            //we will show now the message
                                                            content,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                        }
                                        return Container();
                                      },
                                    ),
                                  ),
                                  //we check here if the last message is not shown and we have more than 14 messages
                                  pos && i > (14)
                                      ? Center(
                                          //if yes a button appear that will lead us to the last message
                                          child: IconButton(
                                            icon: const Icon(
                                              //we display an arrow's icon
                                              Icons.arrow_downward_sharp,
                                              color: Color(0xFF1f3f84),
                                              size: 22,
                                            ),
                                            onPressed: () {
                                              setState(
                                                () {
                                                  //clicking on it will take us to the last message
                                                  list_controller.jumpTo(
                                                    list_controller.position
                                                        .maxScrollExtent,
                                                  );
                                                  //we precise that we attended the last message
                                                  pos = false;
                                                },
                                              );
                                            },
                                          ),
                                        )
                                      //if no the button is not shown
                                      : const SizedBox(
                                          height: 5,
                                        ),
                                  //now wr add the field where we will write the message
                                  TextField(
                                    //that's the controller stocking the message written
                                    controller: myController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 0,
                                        horizontal: 10,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                          color: Colors.white,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      //at the end of the field we add a button clicking on it we will send the message
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          //this variable stock what we write
                                          String message = myController.text;
                                          //this variable stock the username
                                          String username = FirebaseAuth
                                                  .instance
                                                  .currentUser!
                                                  .displayName ??
                                              "";
                                          //this variable stock the ID of the user
                                          String uid = FirebaseAuth
                                              .instance.currentUser!.uid;
                                          //the variable sender receive the username
                                          String sender = username;
                                          //the variable timestamp receive the date and hour when the message is sent
                                          String timestamp =
                                              DateTime.now().toUtc().toString();
                                          //the ID of the message is the timestamp+username
                                          String uid_message =
                                              '${timestamp.replaceAll('.', ',')}_${FirebaseAuth.instance.currentUser!.uid}';
                                          //we make sure that the message is not empty before sending it
                                          if (message.isNotEmpty) {
                                            DatabaseReference newMessageRef =
                                                _messagesRef.child(uid_message);
                                            //now we add the new message to the database
                                            newMessageRef.set({
                                              'content': message,
                                              'sender': sender,
                                              'timestamp': timestamp,
                                              'uid': uid,
                                            });
                                          }
                                          //after sending the message, the field is cleared and we scroll to that new message
                                          myController.clear();
                                          setState(
                                            () {
                                              list_controller.jumpTo(
                                                list_controller
                                                    .position.maxScrollExtent,
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          //we choose her the icon for the send button
                                          Icons.send,
                                          color: Color(0xFF1f3f84),
                                          size: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
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
