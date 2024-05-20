import 'package:best_candidate/Dashboard/home.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/models/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Final extends StatefulWidget {
  final String selectedPlan;
  const Final({super.key, required this.selectedPlan});

  @override
  State<Final> createState() => _FinalState();
}

class _FinalState extends State<Final> with SingleTickerProviderStateMixin {
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
    _controller = AnimationController(vsync: this);
  }

  late AnimationController _controller;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedPlan == "Free"
        ? Scaffold(
            body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(currentUserId)
                .collection('freecvplan')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final resumeDoc = snapshot.data!.docs;
                if (resumeDoc.isEmpty) {
                  return const Center(child: CircleAvatar());
                }

                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView.builder(
                      itemCount: resumeDoc.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final resumes = resumeDoc[index];
                        final institutionName = resumes['institution'];
                        final category = resumes['category'];
                        final companyName = resumes['companyName'];
                        final jobTitle = resumes['jobTitle'];
                        final skills = resumes['skills'];
                        final startEndDate = resumes['startDate'];

                        return Container(
                          color: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                        radius: 30,
                                        child: ClipOval(
                                            child: Image.network(
                                                '${loggedInUser.profilePictureUrl}'))
                                        // NetworkImage('${loggedInUser.profilePictureUrl}'),
                                        ),
                                    Text(
                                      '${loggedInUser.firstName} \n ${loggedInUser.lastName}',
                                      style: const TextStyle(
                                          color: primarycolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          letterSpacing: 1.5),
                                    ),
                                    const Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '${loggedInUser.email}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${loggedInUser.phoneNumber}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${loggedInUser.address}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    jobTitle,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${loggedInUser.bio}'),
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Professional Experience',
                                      style: TextStyle(
                                          color: primarycolor, fontSize: 18),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: primarycolor,
                                ),
                                Text(
                                    'Worked at $companyName, from $startEndDate, I was able to sharpen my skills in $skills. \n  The Working environment was favourable and had fair salary'),
                                    const Divider(
                                  color: primarycolor,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Education',
                                      style: TextStyle(
                                          color: primarycolor, fontSize: 18),
                                    )
                                  ],
                                ),
                                Text('Got a $category from',style: const TextStyle(fontSize: 16),),
                                Text(institutionName,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                const Divider(
                                  color: primarycolor,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Key Skills:',
                                      style: TextStyle(
                                          color: primarycolor, fontSize: 18),
                                    )
                                  ],
                                ),
                                Text(skills.toString())
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ))
        : Scaffold(
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("This Feature will be updates soon"),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                    child: const Text('Home'))
              ],
            )),
          );
  }
}
