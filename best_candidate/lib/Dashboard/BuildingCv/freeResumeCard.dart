import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/models/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FreeResumeCard extends StatefulWidget {
  final String selectedPlan;
  const FreeResumeCard({super.key, required this.selectedPlan});

  @override
  State<FreeResumeCard> createState() => _FreeResumeCardState();
}

class _FreeResumeCardState extends State<FreeResumeCard> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 80,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:38.0),
                  child: Text('${loggedInUser.firstName}  ${loggedInUser.lastName}',style: const TextStyle(fontSize: 32,color: Colors.white),),
                ),
                Text('${loggedInUser.email} | ${loggedInUser.phoneNumber}')
              ],
            ),
          )
        ],
      ),
    );
  }}