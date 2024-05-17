import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/models/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FreeResumeCard extends StatefulWidget {
  const FreeResumeCard({super.key});

  @override
  State<FreeResumeCard> createState() => _FreeResumeCardState();
}

class _FreeResumeCardState extends State<FreeResumeCard> {
User? user = FirebaseAuth.instance.currentUser;

  UserModelOne loggedInUser = UserModelOne(uid: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModelOne.fromMap(value.data());
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:38.0),
                  child: Text('${loggedInUser.firstName}  ${loggedInUser.lastName}'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }}