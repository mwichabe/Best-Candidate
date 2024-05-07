import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/introduction/login/login.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  double _containerSize = 100.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(ConstanceData.logoVideo);
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: true,
      looping: true,
    );
    _controller.initialize().then((_) => setState(() {}));
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _containerSize = 300.0;
    });

    await Future.delayed(const Duration(seconds: 1));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LogIn(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _controller.value.isInitialized
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(ConstanceData.splashBg),
                  ),
                ),
                child: Chewie(controller: _chewieController))
            : Center(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(ConstanceData.splashBg),
                      ),
                    ),
                    child: Center(
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        width: _containerSize,
                        height: _containerSize,
                        child: ClipOval(child: Image.asset(ConstanceData.logo)),
                      ),
                   ))));
  }
}
