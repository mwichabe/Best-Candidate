import 'package:best_candidate/Dashboard/home.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/introduction/complete/complete.dart';
import 'package:best_candidate/introduction/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while the authentication state is being determined
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            // User is authenticated, check Firestore user collection for null values
            final currentUser = FirebaseAuth.instance.currentUser!;
            final userRef = FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid);

            return FutureBuilder<DocumentSnapshot>(
              future: userRef.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while the user data is being fetched
                  return const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    color: primarycolor,
                  ));
                } else if (snapshot.hasData) {
                  final userData =
                      snapshot.data!.data() as Map<String, dynamic>;

                  // Check if any required fields are null
                  if (userData['email'] != null &&
                      userData['profilePictureUrl'] != null) {
                    // All required fields have values, navigate to Home
                    
                      return const Home();
                    
                  } else {
                    // Required fields are null, complete setup
                    return const CompleteSetup();
                  }
                } else {
                  // Error occurred while fetching user data
                  return const Text('Error occurred');
                }
              },
            );
          } else {
            // User is not authenticated, navigate to Login
            return const LogIn();
          }
        },
      ),
    );
  }
}