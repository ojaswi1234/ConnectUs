import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 45, 45),
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text("Account"),
        centerTitle: true,
        backgroundColor: AppTheme.accentDark,
      ),
      body: Container(),
    );
  }
}
