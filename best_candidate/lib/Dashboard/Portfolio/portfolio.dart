import 'package:best_candidate/Dashboard/Portfolio/portfolio_dialog.dart';
import 'package:best_candidate/Dashboard/Portfolio/text_loop_container.dart';
import 'package:best_candidate/widgets/list_of_interview.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Portfolio extends StatefulWidget {
  const Portfolio({Key? key}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Build Your Online Portfolio'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Hi {your name}, We can build you an online portfolio and host it: \nHere is a sample of Portfolio we can build for you.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
               _launchURL();
              },
              child: const Card(
                color: Colors.blue,
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Sample Portfolio',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16,),
             GestureDetector(
              onTap: () {
               showDialog(
          context: context,
          builder: (BuildContext context) {
            return const PortfolioDialog();
          },
        );
              },
              child: const Card(
                color: Colors.blue,
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Get Your Own Portfolio',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
           const Align(
              alignment: Alignment.center,
              child: Text(
                'Get the Job, Here are Sample Interview Questions',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 6,),
            TextLoopContainer(texts: InterviewQuestions.softQuestions
            ),
          ],
        ),
      ),
    );
  }

_launchURL() async {
   final Uri url = Uri.parse('https://mwichabe.github.io/myPortfolio/');
   if (!await launchUrl(url)) {
        throw Exception('Could not launch');
    }
}

}
