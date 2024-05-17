import 'package:best_candidate/Dashboard/BuildingCv/freeResumeCard.dart';
import 'package:flutter/material.dart';

class Resume extends StatefulWidget {
  final String selectedPlan;
  const Resume({super.key, required this.selectedPlan});

  @override
  State<Resume> createState() => _ResumeState();
}

class _ResumeState extends State<Resume> {
  @override
  Widget build(BuildContext context) {
    return  widget.selectedPlan == "Free"?
    FreeResumeCard()
    :
    Text('');
  }
}