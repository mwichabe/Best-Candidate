import 'package:best_candidate/Dashboard/help/help.dart';
import 'package:best_candidate/Dashboard/home.dart';
import 'package:best_candidate/Dashboard/profile/profile.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/introduction/login/login.dart';
import 'package:best_candidate/introduction/signUp/sign_up.dart';
import 'package:best_candidate/widgets/full_photo.dart';
import 'package:best_candidate/models/signUp.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomNavigationDraer extends StatefulWidget {
  const CustomNavigationDraer({super.key});

  @override
  State<CustomNavigationDraer> createState() => _CustomNavigationDraerState();
}

class _CustomNavigationDraerState extends State<CustomNavigationDraer> {
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
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              accountName: Text('${loggedInUser.userName}',
                  style: const TextStyle(color: Colors.white)),
              accountEmail: Text('${loggedInUser.email}',
                  style: const TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                child: ClipOval(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  FullPhotoPage(
                                  url:
                                      loggedInUser.profilePictureUrl ?? '')));
                    },
                    child: CachedNetworkImage(
                      imageUrl: loggedInUser.profilePictureUrl ?? '',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.person,
                        color: primarycolor,
                        size: 20,
                      ),
                      fit: BoxFit.cover,
                      width: 140,
                      height: 140,
                    ),
                  ),
                ),
              )),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home())),
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: const Text('Profile', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushReplacement(
                context,MaterialPageRoute(builder: (context)=>Profile())),
          ),
          ListTile(
            leading: const Icon(Icons.help_center, color: Colors.white),
            title: const Text('Help', style: TextStyle(color: Colors.white)),
            onTap: () => Navigator.pushReplacement(
                context,MaterialPageRoute(builder: (context)=>Help())),
          ),
          ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title:
                  const Text('Log out', style: TextStyle(color: Colors.white)),
              onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Logging Out'),
                        content:
                            const Text('Are you sure you want to proceed?'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Sign out from FirebaseAuth
                              await FirebaseAuth.instance.signOut().then((value) =>  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUp())));
                                
                              // Navigate to the login screen
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )),
          const Divider(
            height: 10,
            color: Colors.grey,
          ),
          ListTile(
              leading: Icon(Icons.delete, color: Colors.red[400]),
              title: const Text('Delete Account',
                  style: TextStyle(color: Colors.white)),
              onTap: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Deleting Account'),
                        content:
                            const Text('Are you sure you want to proceed?'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              user?.delete().then((value) =>
                                  Fluttertoast.showToast(
                                          msg: 'Account deleted Successfully')
                                      .then((value) =>
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignUp()))));
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )),
        ],
      ),
    );
  }
}