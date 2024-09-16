import 'package:flutter/material.dart';
import 'package:mindfull_app/data/sp_helper.dart';
import 'package:mindfull_app/screens/quote_screen.dart';
import 'package:mindfull_app/screens/settings_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String name = '';
  String image = '';

  @override
  void initState() {
    super.initState();
    getSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome screen"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/images/vets.jpg', fit: BoxFit.cover)),
          Center(
              child: Text('Welcome $name', style: const TextStyle(fontSize: 24))),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const QuoteScreen()),
                );
              },
              child: const Text('Ir'))
        ],
      ),
    );
  }

  Future<void> getSettings() async {
    final SPHelpler helper = SPHelpler();
    Map<String, String> settings = await helper.getSettings();
    image = settings['image'] ?? 'Lake';
    name = settings['name'] ?? '';
    setState(() {});
  }
}
