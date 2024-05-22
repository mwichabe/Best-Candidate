import 'package:best_candidate/Dashboard/home.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: [IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
          }, icon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.close),
          ))],
        ),
        body: Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('Best Candidate Help Center'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('Note: This is also the developer\'s contact'),
            ),
            Image.asset(
              ConstanceData.logo,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'This is an official Application, provide official names, incase of any misconduct you will be eligible for an account disclosure. For assistance reach out here: ',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.blue.shade100),
                  child: TextButton(
                      onPressed: () {
                        launchUrl(Uri.parse('tel:+254704858069'));
                      },
                      child: const Text('Call Me')),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.blue.shade100),
                  child: TextButton(
                      onPressed: () {
                        whatsApp();
                      },
                      child: const Text('Text Me Via WhatsApp')),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.blue.shade100),
                  child: TextButton(
                      onPressed: () {
                        openMail();
                      },
                      child: const Text('Mail Me')),
                ),
              ],
            )
          ],
        ),
      ),
    ),
      ));
  }
  openMail() {
  return launchUrl(Uri.parse(
      'mailto:mwichabecollins@gmail.comsubject=Hello&body=Iam using Best Candidate App, I would like to enquire about...)'));
}
whatsApp() {
  return launchUrl(
    Uri.parse(
      'whatsapp://send?phone=+254704858069+&text=Hello, Iam using Best Candidate App'
      ', I would like to enquire about...',
    ),
  );
}
}