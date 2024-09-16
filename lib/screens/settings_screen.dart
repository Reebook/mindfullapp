import 'package:flutter/material.dart';
import 'package:mindfull_app/data/sp_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController txtName = TextEditingController();
  final List<String> _images = ['Lake', 'Mountain', 'Sea', 'Country'];
  String _selectedImage = 'Lake';

@override
void initState(){
  super.initState();
   getSettings();
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(padding: const EdgeInsets.all(16.0),
            child: Column(
            children: [TextField(
              controller: txtName,
              decoration: const InputDecoration(hintText : "Enter your name"),
            ),
            DropdownButton<String>(
              value: _selectedImage,
              items: _images.map((String value){
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newvalue) {
                setState(() {
                    _selectedImage = newvalue ?? 'Lake';
                });
              }
            )
            ],
      )),
    floatingActionButton: FloatingActionButton(
      onPressed: (){
        saveSettings().then((value){
          String message = value ? 'The settings have benn saved'
          : 'Error';
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 3),));
        });
      },
      child: const Icon(Icons.save),),
    );
  }

  Future<bool> saveSettings() async {
    final SPHelpler helper = SPHelpler();
    return await helper.setSettings(txtName.text, _selectedImage);
  }

  Future<void> getSettings() async {
    final SPHelpler helper = SPHelpler();
    Map<String, String> settings = await helper.getSettings();
    _selectedImage = settings['image'] ?? 'Lake';
    txtName.text = settings['name'] ?? '';
    setState(() {
      
    });
  }
}