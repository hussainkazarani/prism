import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prism/colors.dart';
import 'package:prism/main_nav_bar.dart';
import 'package:video_player/video_player.dart';

const String imageTest = 'assets/videos/corrected.mp4';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    _controller = VideoPlayerController.asset(imageTest)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _controller.setLooping(true); // Loop continuously
        _controller.play(); // Start playing automatically
        _navigationTimer = Timer(Duration(seconds: 4), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainNavScreen()),
          );
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Show video on top when initialized
                  if (_isVideoInitialized)
                    Transform.scale(
                      scale: 1.5,
                      child: Container(
                        width: 300,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                    ),
                  // Always show the circular progress indicator
                  Container(
                    width: 300,
                    height: 300,
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
