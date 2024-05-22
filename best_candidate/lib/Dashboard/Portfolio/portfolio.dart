import 'package:best_candidate/Dashboard/Portfolio/portfolio_dialog.dart';
import 'package:best_candidate/Dashboard/Portfolio/text_loop_container.dart';
import 'package:best_candidate/models/signUp.dart';
import 'package:best_candidate/widgets/list_of_interview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Build Your Online Portfolio'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Text(
                'Hi ${loggedInUser.userName}, We can build you an online portfolio and make it accessible to everyone. \nHere is a sample of Portfolio we can build for you.',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                 _launchURL();
                },
                child: const Card(
                  color: Colors.blue,
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Sample Portfolio',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16,),
               GestureDetector(
                onTap: () {
                 showDialog(
            context: context,
            builder: (BuildContext context) {
              return const PortfolioDialog();
            },
          );
                },
                child: const Card(
                  color: Colors.blue,
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Get Your Own Portfolio',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
             const Align(
                alignment: Alignment.center,
                child: Text(
                  'Get the Job, Here are Sample Interview Questions',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(height: 6,),
              TextLoopContainer(texts: InterviewQuestions.softQuestions
              ),
            ],
          ),
        ),
      ),
    );
  }

_launchURL() async {
   final Uri url = Uri.parse('https://mwichabe.github.io/myPortfolio/');
   if (!await launchUrl(url)) {
        throw Exception('Could not launch');
    }
}

}
