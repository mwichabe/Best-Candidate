import 'dart:io';

import 'package:best_candidate/Dashboard/home.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/models/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

//ProfilePage
class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = false;
  User? user = FirebaseAuth.instance.currentUser;

  UserModelOne loggedInUser = UserModelOne(uid: '');
  bool isImageSelected = false;
  final _formKey = GlobalKey<FormState>();

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

  //pick image
  File? _image;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        isImageSelected = true;
      });
    }
    print('$_image');
  }

  //controllers
  TextEditingController firstNameEditingController = TextEditingController();
  TextEditingController lastNameEditingController = TextEditingController();
  TextEditingController bioEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     bool canPop = false;
    return PopScope(
       canPop: canPop,
      onPopInvoked: (bool value) {
        setState(() {
          canPop= !value;
        });

        if (canPop) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Click once more to exit"),
              duration: Duration(milliseconds: 1500),
            ),
          );
        }
      },
      child: Scaffold(
          //backgroundColor: Colors.indigo,
          appBar: AppBar(
            scrolledUnderElevation: 0.0,
            automaticallyImplyLeading: false,
            elevation: 0.0,
            backgroundColor: blueColor,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => const Home()));
                },
              ),
            ],
          ),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              height: constraints.maxHeight,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.centerRight,
                      colors: [primarycolor, blueColor])),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    10,
                    60,
                    20,
                    40,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.fromLTRB(2, 2, 10, 2),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: SizedBox(
                                  height: 180,
                                  width: 180,
                                  child: _image != null
                                      ? Image.file(
                                          _image!,
                                          fit: BoxFit.fill,
                                          height: 180,
                                          width: 180,
                                        )
                                      : Image.network(
                                          loggedInUser.profilePictureUrl ??
                                              'https://static.vecteezy.com/system/resources/thumbnails/002/318/271/small/user-profile-icon-free-vector.jpg',
                                          fit: BoxFit.cover,
                                          width: 140,
                                          height: 140,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(Icons.error),
                                        )),
                            ),
                          ),
                          Positioned(
                            bottom: -10,
                            left: 80,
                            child: IconButton(
                              onPressed: _pickImage,
                              icon: const CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              //username
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'First name Update required';
                                  }
                                  return null;
                                },
                                controller: firstNameEditingController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    hintText: 'Update your first name',
                                    prefixIcon: const Icon(
                                      Icons.person_2,
                                      color: Colors.white,
                                    )),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              //phoneNumber
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Phone update required';
                                  }
                                  return null;
                                },
                                controller: phoneEditingController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    hintText: 'Update your phone number',
                                    prefixIcon: const Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                    )),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // last name
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Update your last name';
                                  }
                                  return null;
                                },
                                controller: lastNameEditingController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    hintText: 'Update your last name',
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // bio
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Update your Bio';
                                  }
                                  return null;
                                },
                                controller: bioEditingController,
                                cursorColor: Colors.white,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    hintText:
                                        'Update your bio',
                                    prefixIcon: const Icon(
                                      Icons.app_registration_rounded,
                                      color: Colors.white,
                                    )),
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          )),
                      
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate() &&
                                  isImageSelected) {
                                setState(() {
                                  isLoading = true;
                                });
                                String UniqueFileName =
                                    DateTime.now().millisecond.toString();
                                Reference referenceRoot =
                                    FirebaseStorage.instance.ref();
                                Reference referenceDirImage =
                                    referenceRoot.child('images');
                                Reference referenceImageToUpload =
                                    referenceDirImage.child(UniqueFileName);
                                try {
                                  await referenceImageToUpload.putFile(_image!);
                                  String imageUrl = await referenceImageToUpload
                                      .getDownloadURL();
                                  loggedInUser.profilePictureUrl = imageUrl;
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user!.uid)
                                      .update({
                                    'firstName': firstNameEditingController.text,
                                    'phoneNumber': phoneEditingController.text,
                                    'lastName':
                                        lastNameEditingController.text,
                                    'bio': bioEditingController.text,
                                    'profilePictureUrl': imageUrl,
                                  });
                                  Fluttertoast.showToast(
                                    msg: 'profile photo updated successfully',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.green,
                                    timeInSecForIosWeb: 1,
                                    fontSize: 16,
                                  ).then((value) =>
                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context)=>Home())));
                                } catch (err) {
                                  print('Firebase Firestore error: $err');
                                  Fluttertoast.showToast(
                                      msg:
                                          'An error occurred while updating your profile\n'
                                          ' if the error persist contact admin');
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg:
                                      'No image selected, please update your profile photo.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16,
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightGreyColor,
                            ),
                            child: const Text('UPDATE PROFILE'),
                          ),
                          if (isLoading) const CircularProgressIndicator(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}