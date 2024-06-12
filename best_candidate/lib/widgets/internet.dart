import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/providers/auth.dart';
import 'package:flutter/material.dart';

class Internet extends StatelessWidget {
  const Internet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(ConstanceData.internet,fit: BoxFit.cover,),
        ),
        ElevatedButton(
           style: ElevatedButton.styleFrom(
            backgroundColor: lightGreyColor
           ),
          onPressed: 
        (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const AuthPage()));
        }
        , child: const Text('Try Again'))
      ],
    );
  }
}