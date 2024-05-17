import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyOrganisations extends StatefulWidget {
  const NearbyOrganisations({Key? key}) : super(key: key);

  @override
  State<NearbyOrganisations> createState() => _NearbyOrganisationsState();
}

class _NearbyOrganisationsState extends State<NearbyOrganisations> {
  late Stream<List<DocumentSnapshot>> _jobsStream;
  late List<DocumentSnapshot> _jobs = [];
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  _startTimer() {
    const duration = Duration(hours: 24);
    Timer.periodic(duration, (Timer timer) {
      setState(() {
        _currentIndex = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<DocumentSnapshot>>(
      stream: _jobsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _jobs = snapshot.data!;
          final int endIndex = _currentIndex + 5 > _jobs.length
              ? (_currentIndex + 5) % _jobs.length
              : _currentIndex + 5;

          final List<DocumentSnapshot> displayedJobs = _jobs.sublist(
            _currentIndex,
            endIndex,
          );

          _currentIndex = endIndex % _jobs.length;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: displayedJobs
                .map((job) => ListTile(
                      title: Text(job['name'] ?? 'Loading...',style: const TextStyle(fontWeight: FontWeight.w700),),
                      subtitle: InkWell(
                          onTap: () async {
                            final Uri url = Uri.parse(job['url']);
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch');
                            }
                          },
                          child: Text(job['url'] ?? 'Loading...',style: const TextStyle(
                            color: Colors.blue,
                            wordSpacing: 1.5
                          ),)),
                    ))
                .toList(),
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return const Center(child: Text('Error fetching data'));
        }
        // Display a loading indicator while waiting
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _jobsStream = FirebaseFirestore.instance
        .collection('jobs')
        .snapshots()
        .map((snapshot) => snapshot.docs);
  }
}
