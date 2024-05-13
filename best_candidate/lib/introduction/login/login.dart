import 'package:best_candidate/Dashboard/home.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/introduction/forgot/reset_password.dart';
import 'package:best_candidate/introduction/signUp/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  void initState() {
    super.initState();
  }

  bool isLoading = false;
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  //firebase
  //final _auth = FirebaseAuth.instance;
  //form key
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //
    //firebase
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(ConstanceData.splashBg),
          ),
        ),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Hey Good to see you again\n',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.white, fontSize: 35),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Welcome Back',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: 1,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ('Email field is required');
                          }
                          //regEx for email
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid  email");
                          }
                          return null;
                        },
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          hoverColor: Colors.white,
                          labelText: 'Email',
                          labelStyle: TextStyle(color: blueColor),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          prefixIcon: Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text,
                        obscureText: _passwordVisible,
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!$@#&*~]).{6,}$');
                          if (value!.isEmpty) {
                            return ('Password field cannot be null');
                          }
                          //regEx for password field
                          if (!regex.hasMatch(value)) {
                            return ('Password should: \n'
                                ' Have at least 6 characters\n '
                                'Have a symbol \n'
                                'Have an uppercase \n'
                                'Have a numeric number \n'
                                'eg. Best@1');
                          }
                          return null;
                        },
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelText: 'Enter Password',
                          labelStyle: const TextStyle(color: blueColor),
                          prefixIcon: const Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Icon(
                              Icons.key,
                              color: Colors.white,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Forgot password?',
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
                          builder: (context) => const ResetPassword()));
                },
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: 160,
                child: ElevatedButton(
                  onPressed: () {
                    signIn(_emailController.text, _passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: lightGreyColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text('New ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  if (isLoading) const CircularProgressIndicator(),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
   void signIn(String email, String password) async {
   if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        // Perform sign-in
        var userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        setState(() {
          isLoading = false;
        });

        // Navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));

        // Show success message
        Fluttertoast.showToast(
          msg: 'Login Successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          timeInSecForIosWeb: 1,
          fontSize: 16,
        );
      } catch (e) {
        print(e.toString());

        setState(() {
          isLoading = false;
        });

        // Show error message
        String errorMessage = 'An error occurred during sign-in.';
        if (e is FirebaseAuthException) {
          switch (e.code) {
            case 'invalid-email':
              errorMessage = 'Invalid email address.';
              break;
            case 'user-not-found':
              errorMessage = 'User not found. Please check your credentials.';
              break;
            case 'wrong-password':
              errorMessage =
                  'Invalid password. Please check your password and try again.';
              break;
            // Add more cases for other possible error codes
            default:
              errorMessage =
                  'An error occurred during sign-in.Check your internet connectivity and try again later.';
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
      }
    }
  }
}
