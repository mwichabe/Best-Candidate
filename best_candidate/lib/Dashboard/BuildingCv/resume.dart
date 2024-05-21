import 'package:best_candidate/Dashboard/BuildingCv/cv_form.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Resume extends StatefulWidget {
  final String selectedPlan;
  const Resume({super.key, required this.selectedPlan});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
   final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    // Get the number of documents in the collection
  Future<int> getCvCount() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('freecvplan')
        .get();
    return snapshot.docs.length;
  }
  @override
  Widget build(BuildContext context) {
    return  
    Scaffold
    (
      backgroundColor: lightGreyColor,
      appBar: AppBar(
        backgroundColor: lightGreyColor,
        automaticallyImplyLeading: false,
        title: FutureBuilder<int>(
                      future: getCvCount(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data! > 0) {
                          return Text(
                            ' You have ${snapshot.data} Resume(s) Generated',
                            style: const TextStyle(
                              color: primarycolor,
                              fontSize: 12,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AdditionalForm(selectedPlan: widget.selectedPlan),
      ));
  }
}