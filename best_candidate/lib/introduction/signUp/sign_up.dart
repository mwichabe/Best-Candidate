import 'dart:developer';

import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/introduction/complete/complete.dart';
import 'package:best_candidate/introduction/login/login.dart';
import 'package:best_candidate/introduction/widgets/our_text_field.dart';
import 'package:best_candidate/models/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final _auth = FirebaseAuth.instance;
  //form key
  final _formKey = GlobalKey<FormState>();
  //editing Controllers
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

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
        body: SingleChildScrollView(
          child: Material(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(ConstanceData.splashBg),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hey Good to see you\n',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: Colors.white, fontSize: 35),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Welcome',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: Colors.white, fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            OurTextFormField(
                                label: 'Email',
                                pasVisible: false,
                                controller: _emailEditingController,
                                validatorText: 'Email Required',
                                regEx: "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]",
                                regExValidatorText: 'Please enter a valid email',
                                keyboardType: TextInputType.emailAddress,
                                iconData: Icons.email),
                            const SizedBox(
                              height: 20,
                            ),
                            OurTextFormField(
                                label: "Phone",
                                pasVisible: false,
                                controller: phoneEditingController,
                                validatorText: 'Phone Required',
                                regEx: '',
                                regExValidatorText: '',
                                keyboardType: TextInputType.phone,
                                iconData: Icons.phone),
                            const SizedBox(
                              height: 20,
                            ),
                            OurTextFormField(
                              label: 'First Name',
                              validatorText: 'Please enter a valid first name.',
                              regEx:
                                  r'^[a-zA-Z]+(?:-[a-zA-Z]+)*(?: [a-zA-Z]+(?:-[a-zA-Z]+)*)*$',
                              regExValidatorText:
                                  'Please enter a valid first name.',
                              keyboardType: TextInputType.text,
                              iconData: Icons.person,
                              pasVisible: false,
                              controller: _firstNameController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            OurTextFormField(
                              label: 'Last Name',
                              validatorText: 'Please enter a valid first name.',
                              regEx:
                                  r'^[a-zA-Z]+(?:-[a-zA-Z]+)*(?: [a-zA-Z]+(?:-[a-zA-Z]+)*)*$',
                              regExValidatorText:
                                  'Please enter a valid first name.',
                              keyboardType: TextInputType.text,
                              iconData: Icons.person,
                              pasVisible: false,
                              controller: _lastNameController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            OurTextFormField(
                              label: 'Username',
                              validatorText: 'Please enter your username.',
                              regEx: r'^[a-zA-Z0-9_.]+$',
                              regExValidatorText: 'Username taken',
                              keyboardType: TextInputType.text,
                              iconData: Icons.person,
                              controller: _userNameController,
                              pasVisible: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            OurTextFormField(
                              label: 'Create your Password',
                              validatorText: 'Please enter your password.',
                              regEx:
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!$@#&*~]).{6,}$',
                              regExValidatorText: 'Password should: \n'
                                  ' Have at least 6 characters\n '
                                  'Have a symbol \n'
                                  'Have an uppercase \n'
                                  'Have a numeric number \n'
                                  'eg. Best@1',
                              keyboardType: TextInputType.text,
                              iconData: Icons.key,
                              controller: _passwordEditingController,
                              pasVisible: true,
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Login ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LogIn()));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 40,
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          //
                           register(_emailEditingController.text,
                                  _passwordEditingController.text);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: lightGreyColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  postDetailsToFirestore() async {
    // calling firestore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    //calling usermodel
    UserModelOne userModel = UserModelOne(uid: '');
    // sending content
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = _firstNameController.text;
    userModel.userName = _userNameController.text;
    userModel.lastName = _lastNameController.text;
    userModel.phoneNumber = phoneEditingController.text;
    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
    Navigator.pushReplacement((context),
        MaterialPageRoute(builder: (context) => const CompleteSetup()));
    Fluttertoast.showToast(
      msg: 'Account created successfully',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      timeInSecForIosWeb: 1,
      fontSize: 16,
    );
  }

  void register(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      await _auth
          .createUserWithEmailAndPassword(
              email: _emailEditingController.text,
              password: _passwordEditingController.text)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        log(e!.message);
        // Show error message
        String errorMessage = 'An error occurred during sign-up.';
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'weak-password':
              errorMessage =
                  'The password is too weak. Please use a stronger password.';
              break;
            case 'email-already-in-use':
              errorMessage =
                  'The email address is already in use. Please choose a different email.';
              break;
            default:
              errorMessage =
                  'An error occurred while creating your account. Check your internet connectivity and try again later.';
          }
        }
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          timeInSecForIosWeb: 1,
          fontSize: 16,
        );
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
