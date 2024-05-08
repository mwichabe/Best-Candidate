import 'package:best_candidate/constance/constance.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class FullPhotoPage extends StatelessWidget {
  final String url;

  const FullPhotoPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text(
          "Full Photo",
          style: TextStyle(color: primarycolor),
        ),
        centerTitle: true,
      ),
      body: PhotoView(
        imageProvider: NetworkImage(url),
      ),
    );
  }
}