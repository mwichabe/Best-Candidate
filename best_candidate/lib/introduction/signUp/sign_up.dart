import 'package:best_candidate/constance/constance.dart';
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
  //
  bool _passwordVisible = false;
  bool _confirmPassVisible = false;
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(ConstanceData.splashBg),
          ),
        )
        , child: SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                 padding: const EdgeInsets.only(top: 200),
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
                ],),
              ),
            ],
          ),
        ),),);
  }
}