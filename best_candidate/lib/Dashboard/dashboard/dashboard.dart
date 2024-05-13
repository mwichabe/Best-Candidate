import 'package:best_candidate/Dashboard/dashboard/error_card.dart';
import 'package:best_candidate/Dashboard/dashboard/home_card.dart';
import 'package:best_candidate/widgets/color_loader.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
   late String quoteText = '';
  late String author = '';
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response =
          await http.get(Uri.parse('https://api.quotable.io/random'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        quoteText = data['content'];
        author = data['author'];
      } else {
        throw Exception('Failed to load data - ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
      errorMessage =
          'Failed to fetch data. Please wait as we try to reconnect.';
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: null,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Word from Best Candidate',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            if (isLoading)
              ColorLoader5()
            else if (errorMessage.isNotEmpty)
              Column(
                children: [
                  Center(child: Text(errorMessage)),
                  ColorLoader5(),
                  ErrorCard()
                ],
              )
            else
              HomeCard(
                text: quoteText,
                author: author,
              ),
          ],
        ),
      ),
    );
  }
}