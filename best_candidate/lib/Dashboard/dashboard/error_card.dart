import 'package:best_candidate/constance/constance.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('About Best Candidate'),
            Image.asset(
              ConstanceData.logo,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'This is an official Application, provide official names, incase of any misconduct you will be eligible for an account disclosure. For more information reach out here: ',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue.shade100),
              child: TextButton(
                  onPressed: () {
                    launchUrl(Uri.parse('tel:+254704858069'));
                  },
                  child: const Text('Call Us')),
            )
          ],
        ),
      ),
    );
  }
}