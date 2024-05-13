import 'dart:async';

import 'package:best_candidate/constance/constance.dart';
import 'package:flutter/material.dart';

class TextLoopContainer extends StatefulWidget {
  final List<String> texts;

  const TextLoopContainer({Key? key, required this.texts}) : super(key: key);

  @override
  _TextLoopContainerState createState() => _TextLoopContainerState();
}

class _TextLoopContainerState extends State<TextLoopContainer> {
  late Timer _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      setState(() {
        _index = (_index + 1) % widget.texts.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250, 
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          color: Colors.grey
        ),
        color: Colors.grey.shade100
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.texts.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Text(widget.texts[_index],
                    style: const TextStyle(fontSize: 20,color: Colors.black, fontWeight: FontWeight.bold)),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}