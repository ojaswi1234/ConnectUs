import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class Voice extends StatefulWidget {
  const Voice({super.key});

  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 124, 112, 0),
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.transparent),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color.fromARGB(255, 124, 112, 0)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                    'assets/profile_placeholder.png'), // Replace with actual image
              ),
              const SizedBox(height: 20),
              const Text(
                'Caller Name', // Replace with dynamic caller name
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Ringing...',
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    speed: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
              const SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.mic_off,
                        color: Colors.white, size: 30),
                    onPressed: () {
                      // Mute logic
                    },
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.call_end, color: Colors.red, size: 50),
                    onPressed: () {
                      // Hang up logic
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up,
                        color: Colors.white, size: 30),
                    onPressed: () {
                      // Speaker logic
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
