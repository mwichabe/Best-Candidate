import 'package:best_candidate/constance/constance.dart';
import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Center(child: Image.asset(ConstanceData.success,
        height: 250,
        width: 250,)),
        const Padding(
          padding: EdgeInsets.all(3.0),
          child: Text('Congratulations your order has been placed,\n  wait as we review your eligibility'),
        ),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: ElevatedButton(onPressed: (){
            Navigator.pushReplacementNamed(context, '/home');
          },
            style: ElevatedButton.styleFrom(
                backgroundColor: primarycolor
              ),child: const Text('Home',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
        )
      ],),
    );
  }
}