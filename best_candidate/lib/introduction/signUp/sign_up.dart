import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/introduction/login/login.dart';
import 'package:best_candidate/introduction/widgets/our_text_field.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  //final _auth = FirebaseAuth.instance;
  //form key
  final _formKey = GlobalKey<FormState>();
  //editing Controllers
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordEditingController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  //
  bool _passwordVisible = false;
  bool _confirmPassVisible = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
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
                            controller: _phoneController,
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
                         SizedBox(
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
                        SizedBox(
                          height: 20,
                        ),
                        OurTextFormField(
                          label: 'Create your Password',
                          validatorText: 'Please enter your password.',
                          regEx: r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!$@#&*~]).{6,}$',
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
    );
  }
}
