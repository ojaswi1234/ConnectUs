import 'package:flutter/material.dart';
import 'package:ConnectUs/utils/app_theme.dart';

class AI_Page extends StatefulWidget {
  const AI_Page({super.key});

  @override
  State<AI_Page> createState() => _AI_PageState();
}

class _AI_PageState extends State<AI_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('ConnectiFly'),
          centerTitle: true,
          backgroundColor: AppTheme.accentDark,
          foregroundColor: const Color.fromARGB(92, 255, 214, 79)),
      body: Container(
        height: double.infinity,
        color: AppTheme.background,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.smart_toy,
                      size: 100, color: const Color.fromARGB(92, 255, 214, 79)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(children: [
                  const TextField(
                      autocorrect: true,
                      style: TextStyle(
                        color: AppTheme.accentDark,
                      ),
                      decoration: InputDecoration(
                        hintText: "Hey There, I am ConnectiFly!!!",
                        focusColor: AppTheme.accentDark,
                        hoverColor: AppTheme.accentDark,
                        fillColor: AppTheme.accentDark,
                      )),
                  IconButton.filled(
                      onPressed: () {
                        print("Message Sent");
                      },
                      icon: const Icon(Icons.send))
                ])),
          ],
        ),
      ),
    );
  }
}
